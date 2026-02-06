{
  flake.modules.nixos.arr = {...}:
  # Default systemd service configuration for all *arr services
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
    systemd.services = {
      sonarr.serviceConfig = default // {};
      sabnzbd.serviceConfig = default // {};
      radarr.serviceConfig = default // {};
      prowlarr.serviceConfig =
        default
        // {
          ProtectSystem = "strict";
        };
    };
  };
}
