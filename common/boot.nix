{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types mkMerge;
  cfg = config.system.secureboot;
in {
  imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  options = {
    system.secureboot.enable = mkOption {
      description = "enable secureboot";
      type = types.bool;
      default = false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = [
        # For debugging and troubleshooting Secure Boot.
        pkgs.sbctl
      ];
      boot.loader.systemd-boot.enable = lib.mkForce false;

      boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    })
    {
      boot = {
        initrd.systemd.enable = true;
        loader.systemd-boot.enable = true;
        #loader.grub.useOSProber = true;
        loader.efi.canTouchEfiVariables = true;
      };
    }
  ];
}
