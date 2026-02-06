{
  flake.modules.nixos.systemd-boot = {...}: {
    boot = {
      initrd.systemd.enable = true;
      loader = {
        systemd-boot.enable = true;
        #loader.grub.useOSProber = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
