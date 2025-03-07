{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types mkIf;
in {
  options = {
    system.games.enable = mkOption {
      description = "enable game launchers";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.system.games.enable {
    #system.desktop.enable = mkDefault true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall =
        true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    programs = {
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      gamemode = {enable = true;};
    };
  };
}
