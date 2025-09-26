{pkgs, ...}: {
  fonts.packages = [pkgs.nerd-fonts.fira-code];
  programs.starship = {
    enable = true; 
    presets = ["nerd-font-symbols"];
  };
}
