{ ... }:

{
  imports = [ ./de ./steam.nix ./1pass.nix];

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings.General.Enable =
    "Source,Sink,Media,Socket"; # Enabling A2DP Sink
  #hardware.bluetooth.settings.General.Experimental =true; # Showing battery charge of bluetooth devices
  home-manager = {
    users.oddbjornmr = import ../../home/desktop;
  };
  services.flatpak.enable = true;

}
