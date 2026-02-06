{inputs, ...}: {
  #declerative minecraft server
  flake-file.inputs = {
    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.modules.nixos.minecraft = {
    imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
    nixpkgs.overlays = [inputs.nix-minecraft.overlay];
  };
}
