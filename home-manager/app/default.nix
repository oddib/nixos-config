{ config, pkgs, ... }:

{
  imports = [
    ./ipass.nix
    ./vivaldi.nix
    ./vscode.nix
  ];
}