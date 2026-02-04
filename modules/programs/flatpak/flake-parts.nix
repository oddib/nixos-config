{...}: {
  flake-file.inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  flake.modules.nixos.flatpak = {inputs, ...}: {
    imports = [inputs.nix-flatpak.nixosModules.Default];
  };
  flake.modules.homeManager.flatpak = {inputs, ...}: {
    imports = [
      inputs.nix-flatpak.homeManagerModules.default
    ];
  };
}
