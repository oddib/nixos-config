{  ... }: {
  imports = [ ./lutris.nix ./steam.nix ./minecraft.nix ];
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode = { enable = true; };
  };
}

