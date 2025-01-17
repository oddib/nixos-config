{ ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;
}
