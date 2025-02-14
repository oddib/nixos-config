# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, ... }: {
  imports = [ # Include the results of the hardware scan.
    #./hardware-configuration.nix
    ./disk-config.nix
    inputs.disko.nixosModules.disko
    ./persistance.nix
    #./galaxybookpro
    ./secureboot.nix
    inputs.nixos-hardware.nixosModules.samsung-galaxybook-2-pro
  ];

  # Bootloader.

  boot = {
    initrd.systemd.enable = true;
    loader.systemd-boot.enable = true;
    #loader.grub.useOSProber = true;
    loader.efi.canTouchEfiVariables = true;
  };
  nixpkgs.hostPlatform = "x86_64-linux";

  # Networking
  networking.hostName = "gobel"; # Define your hostname.
  networking.useDHCP = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
