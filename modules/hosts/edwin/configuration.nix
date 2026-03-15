{inputs, ...}: {
  flake.modules.nixos.edwin = {...}: {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      systemd-boot
      bluetooth
      games
      server
    ];

    services.lact.enable = true;

    # boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
