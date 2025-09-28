{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption types mkOption;
in {
  imports = [
    ./caddy.nix
    ./mediaserver
    ./odoo.nix
    ./foundryvtt.nix
    ./minecraft
    ./nix-serve.nix
    ./printer.nix
    ./tailscale.nix
  ];
  options.roles.server = {
    enable = mkEnableOption "Enable server-configuration";
    mediaserver.enable = mkOption {
      description = "Enable mediaserver-configuration";
      default = config.roles.server.enable;
      type = types.bool;
    };
    minecraft.enable = mkOption {
      description = "Enable minecraft server-configuration";
      default = config.roles.server.enable;
      type = types.bool;
    };
    foundryvtt.enable = mkOption {
      description = "Enable foundryvtt server";
      default = config.roles.server.enable;
      type = types.bool;
    };
  };
}
