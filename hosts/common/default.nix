{ config, pkgs, ... }:

{
  imports =
    [ ./1pass.nix
      ./tailscale.nix
    ];
  home-manager.backupFileExtension = "hm-backup";
  
  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Oslo";

}
