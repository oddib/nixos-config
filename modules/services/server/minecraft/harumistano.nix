{
  flake.modules.nixos.minecraft = {pkgs, ...}: {
    # Minecraft server settings
    services.minecraft-servers.servers.harumistano = {
      enable = true;
      jvmOpts = "-Xmx4G -Xms2G";

      # Specify the custom minecraft server package
      package = pkgs.minecraftServers.vanilla;
      serverProperties = {
        "query.port" = 25564;
        server-port = 25564;
        difficulty = "hard";
        motd = "Harumi stano";
        gamemode = "survival";
        allowFlight = true;
        enableCommandBlock = false;
        view-distance = 20;
        spawn-protection = 0;
        enforce-whitelist = false;
        white-list = false;
      };
    };
  };
}
