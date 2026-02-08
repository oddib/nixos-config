{inputs, ...}: {
  flake.modules.nixos.jellyseerr = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          config.services.jellyseerr.configDir
        ];
      };
    };
  };
}
