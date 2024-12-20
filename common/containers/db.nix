{ lib, ... }: {
  virtualisation.oci-containers.containers."scuffedflix-db" = {
    image = "postgres:17-alpine";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "PGID" = "999";
      "POSTGRES_DB" = "postgres";
      "POSTGRES_PASSWORD_FILE" = "/run/secrets/POSTGRES_PASSWORD";
      "POSTGRES_USER" = "postgres";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "UMASK" = "022";
    };
    volumes = [
      ":/dev/shm:rw"
      "/home/oddbjornmr/docker/postgres:/var/lib/postgresql/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [
      "--health-cmd=pg_isready -U postgres || exit 1"
      "--health-interval=10s"
      "--health-retries=5"
      "--health-timeout=5s"
      "--network-alias=db"
      "--network=default-network"
    ];
  };
  systemd.services."podman-scuffedflix-db" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
}
