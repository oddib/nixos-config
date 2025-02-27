{ ... }:
### Sonarr
let
  default = {
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
    UMask = "0002";
    DeviceAllow = "/dev/null rw";
    RestrictNamespaces = true;
    PrivateDevices = true;
  };
in {
  services.sonarr = {
    enable = true;
    dataDir = "/var/lib/container/sonarr";
    group = "media";
  };
  systemd.services.sonarr.serviceConfig = default // {
    #ProtectSystem = "strict";

  };
  ### Radarr

  services.radarr = {
    enable = true;
    dataDir = "/var/lib/container/radarr";
    group = "media";
  };
  systemd.services.radarr.serviceConfig = default // {
    #ProtectSystem = "strict";
  };
  #prowlarr

  services.prowlarr.enable = true;
  systemd.services.prowlarr.serviceConfig = default // {
    ProtectSystem = "strict";
  };

  #sabnzbd
  services.sabnzbd = {
    enable = true;
    group = "media";
    configFile = "/var/lib/container/sabnzbd/sabnzbd.ini";
  };
  systemd.services.sabnzbd.serviceConfig = default // { };

}
