{ ... }: {
  # Containers
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
  ];
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
  users.groups = { "media" = { }; };
}
