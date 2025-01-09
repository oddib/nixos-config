{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opnix = {
      url = "github:mrjones2014/opnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs =
    { self, nixpkgs, home-manager, nixos-cosmic, opnix, nix-flatpak, disko, impermanence, ... }:
    let
      globalModulesheadless = [
        { system.configurationRevision = self.rev or self.dirtyRev or null; }
        home-manager.nixosModules.home-manager
        opnix.nixosModules.default
      ];
      globalModuleshead = globalModulesheadless ++ [
        nixos-cosmic.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        ./common/default-desktop.nix
      ];
      secureBoot = globalModuleshead ++ [
        impermanence.nixosModules.impermanence
        disko.nixosModules.disko
      ];
    in {
      nixosConfigurations = {
        edwin = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = globalModuleshead ++ [ ./hosts/edwin/default.nix ];
        };
        gobel = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = secureBoot ++ [ ./hosts/gobel/default.nix ];
        };
      };
    };
}
