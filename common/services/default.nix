{
  lib,
  config,
  #inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types;
  cfg = config.system.services;
in {
  imports = [
    ./caddy.nix
    #./opnix.nix
    #inputs.opnix.nixosModules.default
    ./streamer.nix
    ./auth.nix
    ./arr.nix
    ./foundryvtt.nix
    ./minecraft
    ./nix-serve.nix
    ./odoo.nix
  ];
  options = {
    system.services.enable = mkOption {
      description = "Enable server-configuration";
      type = types.bool;
      default = false;
    };
    services.mediaserver.enable = mkOption {
      description = "Enable mediaserver";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    services = {
      nix-serve.enable = true;
      foundryvtt.enable = true;
      mediaserver.enable = true;
      proxy.enable = true;
      minecraft-servers.enable = true;
      odoo-container.enable = true;
    };
    # Containers
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
    ###
    # Create media user
    users.users.media = {
      group = "media";
      isSystemUser = true;
    };
    users.groups = {"media" = {};};
  };
}
