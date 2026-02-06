{
  flake.modules.nixos.shell = {pkgs, ...}: {
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
