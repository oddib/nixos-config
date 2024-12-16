{lib,...}:
{
  virtualisation.oci-containers.containers."speedtest" = {
    image = "ghcr.io/librespeed/speedtest:latest";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "MODE" = "standalone";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "UMASK" = "022";
      "WEBPORT" = "8101";
    };
    log-driver = "journald";
    extraOptions = [
      "--network-alias=speedtest"
      "--network=default-network"
    ];
  };
  systemd.services."podman-speedtest" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    after = [
      "podman-network-default-network.service"
    ];
    requires = [
      "podman-network-default-network.service"
    ];
    partOf = [
      "podman-compose-scuffedflix-root.target"
    ];
    wantedBy = [
      "podman-compose-scuffedflix-root.target"
    ];
  };
}