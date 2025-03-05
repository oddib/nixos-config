{ lib, config, ... }:
let inherit (lib) mkOption mkIf types mkForce;
in {
  options = {
    system.desktop.gnome.enable = mkOption {
      description = "enable audio";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.system.desktop.gnome.enable {
    system.desktop.audio.enable = mkForce true;
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    #services.gnome.core-utilities.enable = false;
  };
}
