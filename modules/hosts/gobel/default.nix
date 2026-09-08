{inputs, ...}: {
  flake.modules.nixos.gobel = {...}: {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      systemd-boot
      bluetooth
      games
      secureboot
      impermanence
      waydroid
    ];

    # boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
