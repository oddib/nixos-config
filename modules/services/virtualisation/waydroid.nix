{
  flake.modules.nixos.waydroid = {...}: {
    virtualisation.waydroid.enable = true;
  };
}
