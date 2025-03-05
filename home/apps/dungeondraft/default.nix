{ osConfig, lib, pkgs, ... }:

{
  config = lib.mkIf osConfig.system.desktop.enable {
    home.packages = [ (pkgs.callPackage ./dungeondraft.nix { }) ];
  };
}
