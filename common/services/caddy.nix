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
          "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e"
          "github.com/greenpau/caddy-security@v1.1.31"
          "github.com/abiosoft/caddy-exec@v0.0.0-20240914124740-521d8736cb4d"
        ];
        hash = "sha256-NWIThHIGOAr8/VUq5yaZ+ZHwX+WSBFEIAwds2ti5M/c=";
      };
      globalConfig = ''
        acme_dns cloudflare {$CLOUDFLARE_API_KEY}
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
