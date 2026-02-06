{inputs, ...}: {
  flake.modules.nixos.jellyseer = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          config.services.jellyseerr.configDir
        ];
      };
    };
  };
}
