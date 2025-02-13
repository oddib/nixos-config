{ ... }: {
  ### Sonarr

  services.sonarr = {
    enable = true;
    dataDir = "/var/lib/container/sonarr";
    group = "media";
  };

  ### Radarr

  services.radarr = {
    enable = true;
    dataDir = "/var/lib/container/radarr";
    group = "media";
  };

  #prowlarr

  services.prowlarr.enable = true;
  systemd.services.sabnzbd.serviceConfig.UMASK = 2;
  #sabnzbd
  services.sabnzbd = {
    enable = true;
    group = "media";
    configFile = "/var/lib/container/sabnzbd/sabnzbd.ini";
  };
}
