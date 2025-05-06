{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption types mkMerge;
  cfg = config.system.secureboot;
in {
  options = {
    system.secureboot.enable = mkOption {
      description = "enable secureboot";
      type = types.bool;
      default = false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };
      environment = {
        persistence."/persist".directories = ["/var/lib/sbctl"];
        systemPackages = [
          pkgs.sbctl
        ];
      };
    })
    {
      boot = {
        initrd.systemd.enable = true;
        loader = {
          systemd-boot.enable = true;
          #loader.grub.useOSProber = true;
          efi.canTouchEfiVariables = true;
        };
      };
    }
  ];
}
