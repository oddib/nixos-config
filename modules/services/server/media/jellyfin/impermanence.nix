{inputs, ...}: {
  flake.modules.nixos.jellyfin = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          config.services.jellyfin.dataDir
        ];
      };
    };
  };
}
