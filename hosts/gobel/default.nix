{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  # Bootloader.
  system = {
    impermanence.enable = true;
    secureboot.enable = true;
    desktop.enable = true;
    games.enable = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Networking
  networking.hostName = "gobel"; # Define your hostname.

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
