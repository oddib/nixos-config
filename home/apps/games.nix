{
  osConfig,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.system.desktop.games.enable {
    home.packages = with pkgs; [
      ### Game launchers
      prismlauncher # minecraft
      lutris # Random other games
      heroic # epic games
      # steam is installed via system pkgs
    ];
  };
}
