{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types;
in {
  imports = [./de ./games.nix ./1pass.nix ./sunshine.nix];
  options = {
    system.desktop.enable = mkOption {
      description = "enable desktop";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.system.desktop.enable {
    environment.systemPackages = [
      pkgs.moonlight-qt
    ];

    # Enable CUPS to print documents.
    #services.printing.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot =
      false; # powers up the default Bluetooth controller on boot
    hardware.bluetooth.settings.General.Enable = "Source,Sink,Media,Socket"; # Enabling A2DP Sink
    #hardware.bluetooth.settings.General.Experimental =true; # Showing battery charge of bluetooth devices
    services.flatpak.enable = true;
  };
}
