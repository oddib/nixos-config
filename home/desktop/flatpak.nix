{ flake-inputs, lib, ... }: {
  imports = [ flake-inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak.update.auto.enable = true;
  services.flatpak.uninstallUnmanaged = false;
  services.flatpak.packages =
    [ "com.adobe.Reader" "com.discordapp.Discord" "org.geogebra.GeoGebra" ];
}
