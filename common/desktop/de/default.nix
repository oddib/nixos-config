{
  lib,
  config,
  ...
}: {
  imports = [./cosmic.nix ./gnome.nix ./audio.nix];
  # Configure keymap
  config = lib.mkIf config.system.desktop.enable {
    system.desktop.gnome.enable = lib.mkDefault true;
    system.desktop.cosmic.enable = lib.mkDefault true;
    services.xserver.xkb = {
      layout = "no";
      variant = "";
    };
  };
}
