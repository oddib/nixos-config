{
  lib,
  config,
  #inputs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.system.services;
in {
  imports = [
    ./wizarr.nix
    ./odoo.nix
  ];
  config = mkIf cfg.enable {
    # Runtime
    virtualisation.docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      enable = true;
      autoPrune.enable = true;
      storageDriver = "btrfs";
    };
    virtualisation.oci-containers.backend = "docker";
  };
}
