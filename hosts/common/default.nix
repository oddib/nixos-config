{ ... }:

{
  imports = [ ./1pass.nix ./tailscale.nix ./flatpak.nix];
  home-manager.backupFileExtension = "hm-backup";

  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  # Select internationalisation properties.
  i18n.defaultLocale = "nb_NO.UTF-8";
  # Configure console keymap
  console.keyMap = "no";

}
