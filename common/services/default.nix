{
  lib,
  config,
  #inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types mkDefault;
  cfg = config.roles.mediaserver;
in {
  imports = [
    ./caddy.nix
    ./mediaserver
    ./odoo
    ./containers
    ./foundryvtt.nix
    ./minecraft
    ./nix-serve.nix
    ./printer.nix
    ./tailscale.nix
  ];
  options = {
    roles.mediaserver.enable = mkOption {
      description = "Enable server-configuration";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    services = {
      nix-serve.enable =mkDefault true;
      foundryvtt.enable = mkDefault true;
      mediaserver.enable = mkDefault true;
      caddy.enable = mkDefault true;
      minecraft-servers.enable = mkDefault true;
      # odoo.enable = mkDefault true;
      #odoo-container.enable = mkDefault true;
    };
  };
}
