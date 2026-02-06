{
  flake.modules.nixos.radarr = {...}: {
    services = {
      radarr = {
        enable = true;
        dataDir = "/var/lib/container/radarr";
        group = "media";
      };
    };
    services.caddy.virtualHosts = {
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
    };
  };
}
