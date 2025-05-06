{
  lib,
  config,
  ...
}:
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
  config = lib.mkIf config.services.mediaserver.enable {
    services.sonarr = {
      enable = true;
      dataDir = "/var/lib/container/sonarr";
      group = "media";
    };
    systemd.services.sonarr.serviceConfig =
      default
      // {
        #ProtectSystem = "strict";
      };
    services.caddy.virtualHosts."sonarr.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
              header X-Webauth-User "{$EMAIL}"
          }

          reverse_proxy @allowedUser http://localhost:8989
          respond "Access denied" 403
      }
    '';

    ### Radarr

    services.radarr = {
      enable = true;
      dataDir = "/var/lib/container/radarr";
      group = "media";
    };
    systemd.services.radarr.serviceConfig =
      default
      // {
        #ProtectSystem = "strict";
      };
    services.caddy.virtualHosts."radarr.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
              header X-Webauth-User "{$EMAIL}"
          }

          reverse_proxy @allowedUser http://localhost:7878
          respond "Access denied" 403
      }
    '';

    #prowlarr

    services.prowlarr.enable = true;
    systemd.services.prowlarr.serviceConfig =
      default
      // {
        ProtectSystem = "strict";
      };
    services.caddy.virtualHosts."prowlarr.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
              header X-Webauth-User "{$EMAIL}"
          }
          reverse_proxy @allowedUser http://localhost:9696
          respond "Access denied" 403
      }
    '';

    #sabnzbd
    services.sabnzbd = {
      enable = true;
      group = "media";
      configFile = "/var/lib/container/sabnzbd/sabnzbd.ini";
    };
    systemd.services.sabnzbd.serviceConfig = default // {};
    environment.persistence."/persist".directories = [
      "/var/lib/container"
      "/var/lib/sabnzbd"
      "/var/lib/radarr"
      "/var/lib/sonarr"
      "/var/lib/prowlarr"
    ];
    services.caddy.virtualHosts."sabnzbd.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
              header X-Webauth-User "{$EMAIL}"
          }

          reverse_proxy @allowedUser http://localhost:4343
          respond "Access denied" 403
      }
    '';
  };
}
