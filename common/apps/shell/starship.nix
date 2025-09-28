{pkgs, ...}: {
  fonts.packages = [pkgs.nerd-fonts.fira-code];
  environment.systemPackages = [pkgs.starship];
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
    presets = ["gruvbox-rainbow"];
  };
}
