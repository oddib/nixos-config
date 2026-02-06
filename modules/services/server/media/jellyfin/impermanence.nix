{inputs, ...}: {
  flake.modules.nixos.jellyfin = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persistent" = {
        directories = [
          config.services.jellyfin.dataDir
        ];
      };
    };
  };
}
