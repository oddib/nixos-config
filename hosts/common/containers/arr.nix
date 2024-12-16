{ lib, ... }:

{
  virtualisation.oci-containers.containers."bazarr" = {
    image = "lscr.io/linuxserver/bazarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:bazarr";
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
      "/home/oddbjornmr/docker/bazarr:/config:rw"
      "/mnt/storage/media:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=bazarr" "--network=default-network" ];
  };
  systemd.services."podman-bazarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  virtualisation.oci-containers.containers."prowlarr" = {
    image = "lscr.io/linuxserver/prowlarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:prowlarr";
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
    volumes = [ "/home/oddbjornmr/docker/prowlarr:/config:rw" ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=prowlarr" "--network=default-network" ];
  };
  systemd.services."podman-prowlarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  virtualisation.oci-containers.containers."radarr" = {
    image = "lscr.io/linuxserver/radarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:radarr";
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
      "/home/oddbjornmr/docker/radarr:/config:rw"
      "/mnt/storage/media:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=radarr" "--network=default-network" ];
  };
  systemd.services."podman-radarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  virtualisation.oci-containers.containers."sonarr" = {
    image = "lscr.io/linuxserver/sonarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:sonarr";
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
      "/home/oddbjornmr/docker/sonarr:/config:rw"
      "/mnt/storage/media:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=sonarr" "--network=default-network" ];
  };
  systemd.services."podman-sonarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };

  virtualisation.oci-containers.containers."sabnzbd" = {
    image = "lscr.io/linuxserver/sabnzbd:latest";
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
      "/home/oddbjornmr/docker/sabnzb:/config:rw"
      "/mnt/storage/media:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=sabnzbd" "--network=default-network" ];
  };
  systemd.services."podman-sabnzbd" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };

}
