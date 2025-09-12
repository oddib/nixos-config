{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  imports = [./vscode.nix ./games.nix ./flatpak.nix];
  config = lib.mkIf osConfig.system.desktop.enable {
    home.packages = with pkgs; [
      ## Vivaldi
      vivaldi
    ];
    programs = {
      vscode.enable = lib.mkDefault true;
    };
  };
}
