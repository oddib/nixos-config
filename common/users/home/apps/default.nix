{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  imports = [./vscode.nix ./flatpak.nix];
  config = lib.mkIf osConfig.roles.desktop.enable {
    home.packages = with pkgs; [
      ## Vivaldi
      (callPackage ./vivaldi.nix {})
    ];
  };
}
