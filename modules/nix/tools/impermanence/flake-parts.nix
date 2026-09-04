{
  # Modules to help you handle persistent state on systems with ephemeral root storage
  # https://github.com/nix-community/impermanence

  flake-file.inputs = {
    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
}
