{
  lib,
  config,
  pkgs,
  ...
}:
###
# Caddy
let
  inherit (lib) mkIf mkForce mkMerge mkDefault;
  cfg = config.services.caddy;
in {
  config = mkMerge [
    {
      services.caddy = {
        enable = mkDefault (config.roles.server.enable || config.roles.server.mediaserver.enable);
        environmentFile = "/etc/caddy/caddy.env";
        # logFormat = lib.mkForce "level DEBUG";
        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/cloudflare@v0.2.2"
          ];
          hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
        };
        globalConfig = ''
          acme_dns cloudflare {$CLOUDFLARE_API_KEY}
        '';
        extraConfig = ''
          (auth) {
              forward_auth unix//run/tailscale-nginx-auth/tailscale-nginx-auth.sock {
                uri /auth
                header_up Remote-Addr {remote_host}
                header_up Remote-Port {remote_port}
                header_up Original-URI {uri}
                copy_headers {
                  Tailscale-User>X-Webauth-User
                  Tailscale-Name>X-Webauth-Name
                  Tailscale-Login>X-Webauth-Login
                  Tailscale-Tailnet>X-Webauth-Tailnet
                  Tailscale-Profile-Picture>X-Webauth-Profile-Picture
                }
              }
            }
        '';
      };
    }

    (mkIf cfg.enable
      {
        services.tailscale.enable = mkForce true;
        services.tailscaleAuth = {
          enable = true;
          user = "caddy";
          group = "caddy";
        };
        environment.persistence."/persist".directories = ["/var/lib/caddy"];
        systemd.services.caddy.serviceConfig = {
          ProtectSystem = "strict";
          ProtectHome = true;
          PrivateTmp = true;
          ProtectProc = "invisible";
          ProtectKernelTunables = true;
          ProtectControlGroups = true;
          AmbientCapabilities = "cap_net_bind_service";
          CapabilityBoundingSet = "cap_net_bind_service";
          UMask = 77;
          #ProtectHostname = true;
          RestrictSUIDSGID = true;
          #ProtectClock = true;
          #ProtectKernelModules= true;
          #PrivateUsers=true;
          SystemCallFilter = "@system-service";
        };
      })
  ];
}
