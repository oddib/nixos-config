{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.system.desktop.enable {
    home.packages = with pkgs; [
      ## Vivaldi 
      vivaldi
    ];
  };
}
