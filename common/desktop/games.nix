{...}: {
  programs = {
    steam = {
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
}
