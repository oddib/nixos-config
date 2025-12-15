{
  lib,
  config,
  ...
}: {
  imports = [./1pass.nix ./games.nix];
  config = lib.mkIf config.roles.desktop.enable {
    ###########################################################################

    ##  Enable the Cosmic Desktop Environment.

    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.defaultSession = "cosmic";

    services.orca.enable = lib.mkForce false; ## SOOOOOO ANNOYING

    ###########################################################################

    ##  Enable the Gnome Desktop Environment.

    #services.displayManager.gdm.enable = true;
    #services.desktopManager.gnome.enable = true;
    # gnome.core-utilities.enable = false;

    ###########################################################################

    ## Audio

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;    # If you want to use JACK applications, uncomment this

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    ###########################################################################

    ## Configure keymap

    services.xserver.xkb = {
      layout = "no";
      variant = "";
    };
  };
}
