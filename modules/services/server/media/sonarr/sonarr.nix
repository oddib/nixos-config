{
  flake.modules.nixos.sonarr = {...}: {
    services = {
      sonarr = {
        enable = true;
        dataDir = "/var/lib/container/sonarr";
        group = "media";
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
    };
  };
}
