{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.tsidp;
in {
  options.services.tsidp = {
    enable = mkEnableOption "tsidp service";

    package = mkOption {
      type = types.package;
      default = pkgs.tailscale;
      description = "The tailscale package containing tsidp.";
    };
    stateDir = mkOption {
      type = types.str;
      default="/var/lib/tsidp";
      example = "/var/lib/tsidp";
      defaultText = "/var/lib/tsidp";
      description = "tsnet state directory";
    };

    funnel = mkOption {
      type = types.bool;
      default = false;
      description = "Use Tailscale Funnel to make tsidp available on the public internet";
    };

    localPort = mkOption {
      type = types.port;
      default=0;
      description = "Allow requests from localhost";
    };

    port = mkOption {
      type = types.port;
      default = 443;
      description = "Port to listen on";
    };

    useLocalTailscaled = mkOption {
      type = types.bool;
      default = false;
      description = "Use local tailscaled instead of tsnet";
    };

    verbose = mkOption {
      type = types.bool;
      default = false;
      description = "Enable verbose logging";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.tsidp = {
      description = "tsidp service";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];

      serviceConfig = {
        ExecStart = concatStringsSep " " (
          [
            "${cfg.package}/bin/tsidp"
          ]
          ++ optional (cfg.stateDir != "") "-dir ${cfg.stateDir}"
          ++ optional cfg.funnel "-funnel"
          ++ optional (cfg.localPort != 0) "-local-port ${toString cfg.localPort}"
          ++ optional (cfg.port != 443) "-port ${toString cfg.port}"
          ++ optional cfg.useLocalTailscaled "-use-local-tailscaled"
          ++ optional cfg.verbose "-verbose"
        );
        Restart = "always";
        RestartSec = "5s";
        User = "root";
        Group = "root";
        #DynamicUser = true;
        #StateDirectory = "tsidp";
        Environment = "TAILSCALE_USE_WIP_CODE=1";
      };
    };
  };
}
