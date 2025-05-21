{pkgs,...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];
  system = {
    desktop.enable = true;
    services.enable = true;
    games.enable = true;
  };
  programs.corectrl.enable = true;
  
  # Try to fix flickering with vrr on cosmic
  environment.etc."profile.d".text = "COSMIC_DISABLE_DIRECT_SCANOUT=1";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  


  # Networking
  networking.hostName = "edwin";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
