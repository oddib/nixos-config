{pkgs,...}: {
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];
  roles = {
    desktop.enable = true;
    mediaserver.enable = true;
    desktop.games.enable = true;
  };
  profiles={
    boot.default=true;
  };
  programs.corectrl.enable = true;
  #services.sunshine.enable = true;
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Networking
  networking.hostName = "edwin";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
