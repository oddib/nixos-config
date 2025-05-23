{...}:

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
  services.sonarr = {
    dataDir = "/var/lib/container/sonarr";
    group = "media";
  };
  
  systemd.services.sonarr.serviceConfig = default // {
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

  #
  # Radarr - Movie Management
  #
  services.radarr = {
    dataDir = "/var/lib/container/radarr";
    group = "media";
  };
  
  systemd.services.radarr.serviceConfig = default // {
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

  #
  # Prowlarr - Indexer Management
  #
  systemd.services.prowlarr.serviceConfig = default // {
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

  #
  # SABnzbd - Usenet Download Client
  #
  services.sabnzbd = {
    group = "media";
    configFile = "/var/lib/container/sabnzbd/sabnzbd.ini";
  };
  
  systemd.services.sabnzbd.serviceConfig = default // {};

  # Persistence configuration for all services
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
}
