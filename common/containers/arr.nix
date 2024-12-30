{ lib, ... }: {
  ###
  # Prowlarr

  virtualisation.oci-containers.containers."prowlarr" = {
    image = "lscr.io/linuxserver/prowlarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:prowlarr";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    user = "media:media";

    volumes = [ "/var/lib/container/prowlarr:/config:rw" ];
    ports = [ "9696:9696" ];
    extraOptions = [ "--network-alias=prowlarr" "--network=default-network" ];
    log-driver = "journald";
  };
  systemd.services."podman-prowlarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };

  ###
  # Radarr

  virtualisation.oci-containers.containers."radarr" = {
    image = "lscr.io/linuxserver/radarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:radarr";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [
      "/var/lib/container/radarr:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    user = "media:media";
    ports = [ "7878:7878" ];
    extraOptions = [ "--network-alias=radarr" "--network=default-network" ];
    log-driver = "journald";
  };
  systemd.services."podman-radarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };

  ###
  # Sonarr

  virtualisation.oci-containers.containers."sonarr" = {
    image = "lscr.io/linuxserver/sonarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:sonarr";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    user = "media:media";
    volumes = [
      "/var/lib/container/sonarr:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    ports = [ "8989:8989" ];
    extraOptions = [ "--network-alias=sonarr" "--network=default-network" ];
    log-driver = "journald";
  };
  systemd.services."podman-sonarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };

  ###
  # SabNZBD
  virtualisation.oci-containers.containers."sabnzbd" = {
    image = "lscr.io/linuxserver/sabnzbd:latest";
    environment = {
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    user = "media:media";
    volumes = [
      "/var/lib/container/sabnzbd:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    ports = [ "8080:8080" ];
    extraOptions = [ "--network-alias=sabnzbd" "--network=default-network" ];
    log-driver = "journald";
  };
  systemd.services."podman-sabnzbd" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
}
