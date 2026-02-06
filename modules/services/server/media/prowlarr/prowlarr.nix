{
  flake.modules.nixos.prowlarr = {...}: {
    services = {
      prowlarr.enable = true;
    };
    services.caddy.virtualHosts = {
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
    };
  };
}
