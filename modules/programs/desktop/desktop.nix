{
  flake.modules.nixos.desktop = {
    lib,
    pkgs,
    ...
  }: {
    ###########################################################################

    ##  Enable the Cosmic Desktop Environment.

    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = true;
    services.displayManager.defaultSession = "cosmic";
    # Try to fix flickering with vrr on cosmic
    environment.etc."profile.d".text = "COSMIC_DISABLE_DIRECT_SCANOUT=1";

    # xdg defaults not working.
    # https://github.com/lilyinstarlight/nixos-cosmic/issues/273
    systemd.user.extraConfig = ''
      DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
    '';
    environment.cosmic.excludePackages = [pkgs.orca];
    services.orca.enable = lib.mkForce false;
    # i cant deal with that stupid noise remove later to test
    ###########################################################################

    ##  Enable the Gnome Desktop Environment.

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
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
