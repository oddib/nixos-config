{ pkgs, ... }:

{
  imports =
    [ ./flatpak.nix ./vivaldi.nix ./vscode.nix ./dungeondraft ];

  home.packages = with pkgs; [
    ### Game launchers
    prismlauncher # minecraft
    lutris # Random other games
    heroic # epic games
    # steam is installed via system pkgs
  ];
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };

}
