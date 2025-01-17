{ inputs, ... }: {
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  services.flatpak.enable = true;
  services.flatpak.packages =
    [ "com.adobe.Reader" "com.discordapp.Discord" "org.geogebra.GeoGebra" ];
}
