{inputs, ...}: {
  flake-file.inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  flake.modules.nixos.flatpak = {...}: {
    imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];
  };
  flake.modules.homeManager.flatpak = {...}: {
    imports = [
      inputs.nix-flatpak.homeManagerModules.nix-flatpak
    ];
  };
}
