{...}: {
  flake.modules.nixos.containers = {
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
