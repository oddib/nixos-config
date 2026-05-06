{
  flake.modules.homeManager.protonmail = {pkgs, ...}: {
    home.packages = [pkgs.protonmail-desktop];
  };
}
