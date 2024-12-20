{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-flatpak.url =
      "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opnix = {
      url = "github:mrjones2014/opnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, nixos-cosmic, opnix, nix-flatpak, ...
    }@inputs:
    let
      globalModulesheadless = [
        { system.configurationRevision = self.rev or self.dirtyRev or null; }
        home-manager.nixosModules.home-manager
        opnix.nixosModules.default

      ];
      globalModuleshead = globalModulesheadless ++ [
        nixos-cosmic.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak

      ];

    in {
      nixosConfigurations = {
        # TODO please change the hostname to your own
        edwin = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = globalModuleshead ++ [ ./hosts/edwin/default.nix ];
        };
      };
    };
}
