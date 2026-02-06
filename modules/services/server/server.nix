{inputs, ...}: {

  flake.modules.nixos.server = {
    imports = with inputs.self.modules.nixos; [
      caddy
      foundryvtt
      minecraft
      media
    ];
  };
}
