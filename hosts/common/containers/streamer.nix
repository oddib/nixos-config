{ lib, ... }: {
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "lscr.io/linuxserver/jellyfin:latest";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [
      "/home/oddbjornmr/docker/jellyfin:/config:rw"
      "/mnt/storage/media/media:/data/media:ro"
    ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=jellyfin" "--network=default-network" ];
  };
  systemd.services."podman-jellyfin" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  virtualisation.oci-containers.containers."jellyseerr" = {
    image = "fallenbagel/jellyseerr:latest";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [ "/home/oddbjornmr/docker/jellyseerr:/app/config:rw" ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=jellyseerr" "--network=default-network" ];
  };
  systemd.services."podman-jellyseerr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
}
