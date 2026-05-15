{
  flake.modules.nixos.games = {pkgs, ...}: {
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        remotePlay.openFirewall =
          true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall =
          true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall =
          true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      # gamescope = {
      #   capSysNice = true;
      # };
    };
    # services.sunshine = {
    #   autoStart = false;
    #   capSysAdmin = true;
    #   openFirewall = false;
    # };
  };
  flake.modules.homeManager.games = {pkgs, ...}: {
    home.packages = with pkgs; [
      #moonlight-qt
      prismlauncher # minecraft
      # lutris # Random other games
      heroic # epic games
    ];
  };
}
