{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.roles.desktop.enable {
    home.packages = [(pkgs.callPackage ./dungeondraft.nix {})];
  };
}
