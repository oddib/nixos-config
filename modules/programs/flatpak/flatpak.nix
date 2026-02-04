{
  flake.modules.homeManager.flatpak = {lib, ...}: {
    services.flatpak.update.auto.enable = true;
    services.flatpak.uninstallUnmanaged = true;
    services.flatpak.packages = [
      "com.adobe.Reader"
      "com.discordapp.Discord"
      "org.geogebra.GeoGebra"
      "com.spotify.Client"
      "com.github.iwalton3.jellyfin-media-player"
    ];
  };
}
