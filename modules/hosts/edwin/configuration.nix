{inputs, ...}: {
  flake.modules.nixos.edwin = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      systemd-boot
      bluetooth
      games
      server
    ];

    services.lact.enable = true;

    boot.kernelPackages = pkgs.linuxPackages_latest;
    # Networking
    networking.hostName = "edwin";
  };
}
