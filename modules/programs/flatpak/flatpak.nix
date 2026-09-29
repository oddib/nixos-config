{
  flake.modules.homeManager.flatpak = {...}: {
    services.flatpak.update.auto.enable = true;
    services.flatpak.uninstallUnmanaged = true;
    services.flatpak.packages = [
      "com.discordapp.Discord"
      "com.spotify.Client"
    ];
  };
  flake.modules.nixos.flatpak = {...}: {
    services.flatpak = {
      enable = true;
    };
  };
}
