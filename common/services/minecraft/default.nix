{ inputs, ... }: # Make sure the flake inputs are in your system's config
{
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./oddpack.nix 
  ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
}
