{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.roles.desktop.games.enable {
    environment.systemPackages = with pkgs; [
      moonlight-qt
      prismlauncher # minecraft
      lutris # Random other games
      heroic # epic games
    ];

    programs = {
      gamemode.enable = true;
      # gamescope.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall =
          true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall =
          true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall =
          true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      gamescope = {
        capSysNice = true;
      };
    };
    services.sunshine = {
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}
