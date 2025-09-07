{
  lib,
  pkgs,
  ...
}: {
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
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce ["multi-user.target"];
  # Set password for nixos user
  users.users.nixos = {
    initialHashedPassword = lib.mkForce "$y$j9T$j5mWbJa5mXvS2FIRMCTP21$P8hEoOkSnxu.cWcR3RW.Qvo3QOu40nm18xZyIhZ9ki1"; # "nixos";
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXcB7DA03BxX1nO7xzL1Uyx496xJyY70RdIIuRbjS02Kx2aDKji7n8YBW7qa4imfNx4blPySLe2a3QBWx4Alx6e3yG7wtzHsm8vcHTCzjW9Xx9vtllSxtoZ0nLuYFzRvSIzZyjNTITbhBy6sLTEx99oLe70bR6HIokvd+PZbxyi7fZ6IHUSXehU/es+650+4TxOms/GunMLOePeTHxlQBh45ZKTKD+eux9WmVrlXzJqU2gJkFohxC6kXdRdHjqyAj+lXalbVPasfTInpxmhbOBZ2REJO50jsuSr8u1awrKBbG4HbDSYiBBntSGvVBlmQ5/vhtRr/HU69lGTlEHSoBbundU4QJB9hNThe/POvpfQU68nplgdSWJybqJ5bkFee1kvJyXLhN4vdS33wfGCYHnQ5EbbFGVuvI928tXIDD4FFBIL8VKKNzJaXBBK2eRePW9St4BjWETaAIQQ7sbnAKdnltA7k1gznD2h3wtJE/ngsVX6r2QaubbuI1/tMLIUdM= nixos@192.168.0.180"];
  };

  services.openssh = {
    enable = true;
    settings = {
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
