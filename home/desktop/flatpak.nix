{ flake-inputs, ... }: {
  imports = [ flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.update.auto.enable = true;
  #services.flatpak.uninstallUnmanaged = true;
  services.flatpak.packages = [
    "com.adobe.Reader"
    "com.discordapp.Discord"
    "org.geogebra.GeoGebra"
    "com.spotify.Client"
    "com.github.iwalton3.jellyfin-media-player"  ];
}
