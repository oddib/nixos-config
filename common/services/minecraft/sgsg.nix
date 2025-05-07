{
  pkgs,
  inputs,
  ...
}: {
  # Minecraft server settings
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers.servers.sgsg = {
    enable = true;
    jvmOpts = "-Xmx4G -Xms2G";

    # Specify the custom minecraft server package
    package = pkgs.minecraftServers.vanilla-1_21_5;
    serverProperties = {
      difficulty = "hard";
      motd = "Sandnes ghetto sykkel gjeng";
      gamemode = "survival";
      allowFlight = true;
      enableCommandBlock = true;
      viewDistance = 20;
    };
  };
}
