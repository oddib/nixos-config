{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf types mkForce;
in {
  options = {
    system.desktop.cosmic.enable = mkOption {
      description = "enable cosmic de";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.system.desktop.cosmic.enable {
    system.desktop.audio.enable = mkForce true;
    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
