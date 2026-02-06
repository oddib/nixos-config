{
  flake.modules.nixos.l18n = {
    # Set your time zone.
    time.timeZone = "Europe/Oslo";
    # Select internationalisation properties.
    i18n = {
      defaultLocale = "nb_NO.UTF-8";
    };
    ## Configure console keymap
    console.keyMap = "no";
    ## keyboard
    services.xserver.xkb = {
      layout = "no";
      variant = "";
    };
  };
}
