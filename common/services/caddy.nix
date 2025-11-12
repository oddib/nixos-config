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
  scrt = config.services.onepassword-secrets.secrets;
in {
  config = mkMerge [
    {
      services.caddy = {
        enable = mkDefault (config.roles.server.enable || config.roles.server.mediaserver.enable);
        environmentFile = scrt.caddyenv.path;
        # logFormat = lib.mkForce "level DEBUG";
        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/cloudflare@v0.2.1"
          ];
          hash = "sha256-XwZ0Hkeh2FpQL/fInaSq+/3rCLmQRVvwBM0Y1G1FZNU=";
        };
        globalConfig = ''
          acme_dns cloudflare {file.${scrt.CF-key.path}}
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
              @allowedUser {
                header X-Webauth-User "{$EMAIL}"
              }
            }
        '';
      };
    }

    (mkIf cfg.enable
      {
        services = {
          onepassword-secrets.secrets = {
            CF-key = {
              reference = "op://secrets/Cloudflare/api-key";
              owner = "caddy";
              services = ["caddy"];
              path = "/etc/caddy/CFapi";
            };
            caddyenv = {
              reference = "op://secrets/caddy.env/.env";
              owner = "caddy";
              services = ["caddy"];
              path = "/etc/caddy/.env";
            };
          };
          tailscale.enable = mkForce true;
          tailscaleAuth = {
            enable = true;
            user = "caddy";
            group = "caddy";
          };
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
