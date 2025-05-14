{lib,pkgs, ...}: {
  # Bootloader.
  # Networking
  networking = {
    hostName = "nixos"; # Define your hostname.
  };

  # Show IP address on console on boot
  #networking.dhcpcd.runHook = "${pkgs.systemd}/bin/systemd-cat -t dhcpcd echo Interface $interface: $new_ip_address";

  environment.systemPackages = [
    pkgs.wifi-qr
  ];

  # Set password for nixos user
  users.users.nixos.initialHashedPassword = lib.mkForce "$y$j9T$j5mWbJa5mXvS2FIRMCTP21$P8hEoOkSnxu.cWcR3RW.Qvo3QOu40nm18xZyIhZ9ki1"; # "nixos";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      # Permit root login for live ISO
      PermitRootLogin = "yes";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
