{inputs, ...}: {
  # Manage a user environment using Nix
  # https://github.com/

  flake-file.inputs = {
    foundryvtt = {
      url = "github:nix-foundryvtt/nix-foundryvtt";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.modules.nixos.foundryvtt = {
    imports = [inputs.foundryvtt.nixosModules.foundryvtt];
  };
}
