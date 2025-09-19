{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkDefault mkMerge;
  cfg = config.profiles.boot;
in {
  options.profiles.boot = {
    nothing = mkEnableOption "Disable all boot profiles";
    default = mkEnableOption "Standard boot setup";
    secureboot = mkEnableOption "UEFI Secure Boot (composes with default)";
    legacy = mkEnableOption "Legacy BIOS boot";
  };
  config = mkMerge [
    (mkIf (cfg.default && !cfg.nothing) {
      boot = {
        initrd.systemd.enable = mkDefault true;
        loader = {
          systemd-boot.enable = mkDefault true;
          #loader.grub.useOSProber = true;
          efi.canTouchEfiVariables = mkDefault true;
        };
      };
    })
    (mkIf (cfg.secureboot && !cfg.nothing) {
      profiles.boot.default = mkDefault true;
      boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };
      environment = {
        persistence."/persist".directories = [ config.boot.lanzaboote.pkiBundle];
        systemPackages = [
          pkgs.sbctl
        ];
      };
    })
    (mkIf (cfg.legacy && !cfg.nothing) {
      boot.loader.grub.enable = true;
      boot.loader.systemd-boot.enable = false;
    })

    {
      
    }
  ];
}
