# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko/latest";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    foundryvtt = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oddib/nix-foundryvtt";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    impermanence.url = "github:nix-community/impermanence";
    import-tree.url = "github:vic/import-tree";
    lanzaboote = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/lanzaboote/v1.0.0";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-minecraft = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Infinidoge/nix-minecraft";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    packages = {
      flake = false;
      url = "path:./packages";
    };
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };

}
