{ ... }:

{
  imports = [ ./default.nix ./flatpak.nix ./de/default.nix ./games/default.nix];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot =
    true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings.General.Enable =
    "Source,Sink,Media,Socket"; # Enabling A2DP Sink
  hardware.bluetooth.settings.General.Experimental =
    true; # Showing battery charge of bluetooth devices
  home-manager = {
    users.oddbjornmr = import ../home-manager/default-desktop.nix;
  };
}
