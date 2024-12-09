  { config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./xserver.nix
    ];
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}