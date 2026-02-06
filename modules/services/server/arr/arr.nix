{
  flake.modules.nixos.arr = {...}:
  # Default systemd service configuration for all *arr services
  {
    #
    # Sonarr - TV Show Management
    #
    services = {
      sonarr = {
        enable = true;
        dataDir = "/var/lib/container/sonarr";
        group = "media";
      };
      radarr = {
        enable = true;
        dataDir = "/var/lib/container/radarr";
        group = "media";
      };
      prowlarr.enable = true;
      sabnzbd = {
        enable = true;
        group = "media";
        secretFiles = [/var/lib/container/sabnzbd/sabnzbd.ini];
      };
    };
    services.caddy.virtualHosts = {
      "sonarr.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
            header X-Webauth-User "{$EMAIL}"
          }
          reverse_proxy @allowedUser http://localhost:8989
          respond "Access denied" 403
        }
      '';

      "radarr.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
            header X-Webauth-User "{$EMAIL}"
          }
          reverse_proxy @allowedUser http://localhost:7878
          respond "Access denied" 403
        }
      '';

      "prowlarr.{$DOMAIN}".extraConfig = ''
        route {
          import auth
          @allowedUser {
            header X-Webauth-User "{$EMAIL}"
          }
          reverse_proxy @allowedUser http://localhost:9696
          respond "Access denied" 403
        }
      '';

      "sabnzbd.{$DOMAIN}".extraConfig = ''
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
  };
}
