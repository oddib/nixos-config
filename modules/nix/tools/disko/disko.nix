{
  # Modules to help you handle persistent state on systems with ephemeral root storage
  # https://github.com/nix-community/impermanence

  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}