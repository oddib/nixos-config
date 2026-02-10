{
  flake.modules.nixos.sabnzbd = {...}: {
    services = {
      sabnzbd = {
        enable = true;
        group = "media";
        secretFiles = [/var/lib/container/sabnzbd/sabnzbd.ini];
        configFile = null; ## remove if system.stateversion > 26.05
      };
    };
    services.caddy.virtualHosts = {
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
