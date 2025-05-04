{
  lib,
  config,
  pkgs,
  ...
}:
###
# Caddy
let
  inherit (lib) mkIf mkOption types mkForce;
  cfg = config.services.proxy;
in {
  options = {
    services.proxy.enable = mkOption {
      description = "Enable proxy";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    services.tailscale.enable = mkForce true;
    services.tailscaleAuth = {
      enable = true;
      user = "caddy";
      group = "caddy";
    };

    services.caddy = {
      enable = true;
      environmentFile = "/etc/caddy/caddy.env";
      # logFormat = lib.mkForce "level DEBUG";
      package = pkgs.caddy.withPlugins {
        plugins = [
          "github.com/caddy-dns/cloudflare@v0.2.1"
        ];
        hash = "sha256-saKJatiBZ4775IV2C5JLOmZ4BwHKFtRZan94aS5pO90=";
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
  };
}
