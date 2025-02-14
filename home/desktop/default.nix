{ pkgs, ... }:

{
  imports = [ ./flatpak.nix ./1pass.nix ./vivaldi.nix ./vscode.nix ./dungeondraft];
  
  home.packages = with pkgs; [ 
    ### Game launchers
    prismlauncher # minecraft
    lutris # Random other games
    heroic # epic games
    # steam is installed via system pkgs
    ];

}
