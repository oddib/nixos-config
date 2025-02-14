{ lib, pkgs, config, ... }: {
  imports = [ ../../common/cpu/intel/alder-lake/cpu-only.nix ];

  ###
  # Kernel module by Joshua Grisham, added features in readme
  # https://github.com/joshuagrisham/samsung-galaxybook-extras
  # deactivate with:
  # hardware.samsung-galaxybook.enable =  false;
  # 

  boot.extraModulePackages = [
    (pkgs.callPackage ./kmod.nix {
      kernel = config.boot.kernelPackages.kernel;
    })
  ];
  boot.kernelModules = [ "samsung-galaxybook" "kvm-intel" ];

  boot.kernelParams = [ "i915.enable_dpcd_backlight=3" ];
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  services.fprintd.enable = lib.mkDefault true;

}
