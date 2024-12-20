{ ... }: {
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
    ports = [
      "8096:8096"
    ];
  };
  virtualisation.oci-containers.containers."jellyseerr" = {
    image = "fallenbagel/jellyseerr:latest";
    environment = {
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UMASK" = "022";
    };
    ports = [
      "5055:5055"
    ];
    volumes = [ "/var/lib/container/jellyseerr/:/app/config:rw" ];
  };
}
