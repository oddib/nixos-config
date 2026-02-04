{inputs, ...}: {
  # Manage a user environment using Nix
  # https://github.com/

  flake-file.inputs = {
    foundryvtt = {
      url = "github:oddib/nix-foundryvtt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [inputs.foundryvtt.nixosModules.foundryvtt];
}
