{
  flake.modules.nixos.starship = {pkgs, ...}: {
    environment.systemPackages = [pkgs.starship];
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
      };
      presets = ["gruvbox-rainbow"];
    };
  };
}
