{ ...}: {
  # Manage a user environment using Nix
  # https://github.com/nix-community/home-manager

  flake-file.inputs = {
    nixos-hardware.url = "github:oddib/nixos-hardware";
  };
}
