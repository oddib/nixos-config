{ ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./ekstra-disks.nix
  ];
  system = {
    desktop.enable = true;
    services.enable = true;
    games.enable = true;
  };

  # Networking
  networking.hostName = "edwin";

  programs.corectrl.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id == "org.corectrl.helper.init" || 
           action.id == "org.corectrl.helperkiller.init") && 
          subject.local == true && 
          subject.active == true && 
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
