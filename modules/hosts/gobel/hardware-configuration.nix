{inputs, ...}: {
  flake.modules.nixos.gobel = {modulesPath, ...}: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      inputs.nixos-hardware.nixosModules.samsung-galaxybook-2-pro
    ];
  };
}
