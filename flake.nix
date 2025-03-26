{
  description = "NixOS configuration";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixos-cosmic/nixpkgs"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      #inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs"; # Bad but i want faster eval time
    };
    nixos-hardware.url = "github:oddib/nixos-hardware";
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
      #  inputs.pre-commit-hooks-nix.follows = "";
      #inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    };
    foundryvtt = {
      url = "github:reckenrode/nix-foundryvtt";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #opnix = {
    #  url = "github:mrjones2014/opnix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-cosmic,
    nix-flatpak,
    disko,
    impermanence,
    foundryvtt,
    nix-minecraft,
    lanzaboote,
    nixos-hardware,
  } @ inputs: let
    common_modules = [
      {system.configurationRevision = self.rev or self.dirtyRev or null;}
      ./common
    ];
    desktop_modules = common_modules ++ [./common/desktop];
  in {
    nixosConfigurations = {
      edwin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = desktop_modules ++ [./hosts/edwin];
      };
      gobel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = desktop_modules ++ [./hosts/gobel];
      };
    };
  };
}
