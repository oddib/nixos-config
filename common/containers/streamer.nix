{ lib, ... }: {
  virtualisation.oci-containers.containers."jellyfin" = {
    image = "lscr.io/linuxserver/jellyfin:latest";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [
      "/var/lib/container/jellyfin:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    ports = [ "8096:8096" ];
    devices = [
      "/dev/dri/renderD128:/dev/dri/renderD128"
      "/dev/dri/card1:/dev/dri/card1"
    ];
    extraOptions = [ "--network-alias=jellyfin" "--network=default-network" ];
    systemd.services."podman-jellyfin" = {
      serviceConfig = { Restart = lib.mkOverride 90 "always"; };
      after = [ "podman-network-default-network.service" ];
      requires = [ "podman-network-default-network.service" ];
      partOf = [ "podman-compose-scuffedflix-root.target" ];
      wantedBy = [ "podman-compose-scuffedflix-root.target" ];
    };
  };
  virtualisation.oci-containers.containers."jellyseerr" = {
    image = "fallenbagel/jellyseerr:latest";
    environment = {
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    ports = [ "5055:5055" ];
    volumes = [ "/var/lib/container/jellyseerr/:/app/config:rw" ];
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
