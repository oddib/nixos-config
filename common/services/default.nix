{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
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
    mediaserver.enable = mkEnableOption "Enable mediaserver-configuration" // {default = config.roles.server.enable;};
    minecraft.enable = mkEnableOption "Enable minecraft server-configuration" // {default = config.roles.server.enable;};
    foundryvtt.enable = mkEnableOption "Enable foundryvtt server" // {default = config.roles.server.enable;};
  };
}
