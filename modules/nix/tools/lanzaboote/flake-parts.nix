{inputs, ...}: {
  # Manage a user environment using Nix
  # https://github.com/nix-community/home-manager

  flake-file.inputs = {
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.modules.nixos.secureboot = {
    imports = [inputs.lanzaboote.nixosModules.lanzaboote];
  };
}
