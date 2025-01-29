{ lib, config, pkgs, ... }:

let
  kernel = config.boot.kernelPackages;
in {
  options = {
    hardware.samsung-galaxybook.enable = lib.mkEnableOption "Samsung Galaxybook extras";
  };

  config = lib.mkIf config.hardware.samsung-galaxybook.enable {
    boot.extraModulePackages = [ (pkgs.callPackage ./module.nix { linux = kernel.kernel; }) ];
    boot.kernelModules = [ "samsung-galaxybook" ];
  };
}