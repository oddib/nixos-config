{ ... }:

{
  imports = [ ./audio.nix ];
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
}
