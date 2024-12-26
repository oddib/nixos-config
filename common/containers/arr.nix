{ ... }:

{
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
    volumes = [ "/var/lib/container/prowlarr:/config:rw" ];
    ports = [ "9696:9696" ];
  };
  virtualisation.oci-containers.containers."radarr" = {
    image = "lscr.io/linuxserver/radarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:radarr";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [
      "/var/lib/container/radarr:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    ports = [ "7878:7878" ];
  };
  virtualisation.oci-containers.containers."sonarr" = {
    image = "lscr.io/linuxserver/sonarr:latest";
    environment = {
      "DOCKER_MODS" = "ghcr.io/gilbn/theme.park:sonarr";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [
      "/var/lib/container/sonarr:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    ports = [ "8989:8989" ];
  };
  virtualisation.oci-containers.containers."sabnzbd" = {
    image = "lscr.io/linuxserver/sabnzbd:latest";
    environment = {
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    volumes = [
      "/var/lib/container/sabnzbd:/config:rw"
      "/persist/storage/media:/data/media:ro"
    ];
    ports = [ "8080:8080" ];
  };
}
