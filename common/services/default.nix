{
  lib,
  config,
  #inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.system.services;
in {
  imports = [
    ./caddy.nix
    ./mediaserver
    ./containers
    ./foundryvtt.nix
    ./minecraft
    ./nix-serve.nix
  ];
  options = {
    system.services.enable = mkOption {
      description = "Enable server-configuration";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    services = {
      nix-serve.enable = true;
      foundryvtt.enable = true;
      mediaserver.enable = true;
      caddy.enable = true;
      minecraft-servers.enable = true;
      odoo-container.enable = true;
    };
  };
}
