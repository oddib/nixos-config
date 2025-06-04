{
  lib,
  config,
  ...
}:
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
  #
  # Sonarr - TV Show Management
  #
  config = lib.mkMerge [
    (lib.mkIf config.services.sonarr.enable {
      services.sonarr = {
        dataDir = "/var/lib/container/sonarr";
        group = "media";
      };
      environment.persistence."/persist".directories = [
        config.services.sonarr.dataDir
      ];
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
    })
    #
    # Radarr - Movie Management
    #

    (lib.mkIf config.services.radarr.enable {
      services.radarr = {
        dataDir = "/var/lib/container/radarr";
        group = "media";
      };
      environment.persistence."/persist".directories = [
        config.services.radarr.dataDir
      ];

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
    })
    #
    # Prowlarr - Indexer Management
    #

    (lib.mkIf config.services.prowlarr.enable {
      environment.persistence."/persist".directories = [
        config.services.prowlarr.dataDir
      ];

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
    })
    #
    # SABnzbd - Usenet Download Client
    #
    (lib.mkIf config.services.sabnzbd.enable {
      services.sabnzbd = {
        group = "media";
        configFile = "/var/lib/container/sabnzbd/sabnzbd.ini";
      };
      environment.persistence."/persist".files = [
        {
          file = config.services.sabnzbd.configFile;
          user = config.services.sabnzbd.user;
          group = config.services.sabnzbd.group;
          parentDirectory = {
            mode = "u=rwx,g=,o=";
          };
        }
      ];

      systemd.services.sabnzbd.serviceConfig = default // {};


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
    })
  ];
}
