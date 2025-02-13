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
  systemd.services.prowlarr.serviceConfig = {
    ProtectSystem = "strict";
    InaccessiblePaths = "...";
    ProtectHome = true;
    PrivateTmp = true;
    ProtectProc = "invisible";
    ProtectKernelTunables = true;
    ProtectControlGroups = true;
    AmbientCapabilities = "";
    CapabilityBoundingSet = "";
    ProtectHostname = true;
    RestrictSUIDSGID = true;
    ProtectClock = true;
    ProtectKernelModules = true;
    PrivateUsers = true;
    SystemCallFilter = "@system-service";
    UMask = "0077";
    DeviceAllow = "";
    RestrictNamespaces = true;
    PrivateDevices = true;
  };

  #sabnzbd
  services.sabnzbd = {
    enable = true;
    group = "media";
    configFile = "/var/lib/container/sabnzbd/sabnzbd.ini";
  };
  systemd.services.sabnzbd.serviceConfig = {
    #ProtectSystem = "strict";
    InaccessiblePaths = "...";
    ProtectHome = true;
    PrivateTmp = true;
    ProtectProc = "invisible";
    ProtectKernelTunables = true;
    ProtectControlGroups = true;
    AmbientCapabilities = "";
    CapabilityBoundingSet = "";
    ProtectHostname = true;
    RestrictSUIDSGID = true;
    ProtectClock = true;
    ProtectKernelModules = true;
    PrivateUsers = true;
    SystemCallFilter = "@system-service";
    UMask = "0077";
    DeviceAllow = "";
  };

}
