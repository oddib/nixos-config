{inputs, ...}: {
  flake.modules.nixos.jellyseer = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persistent" = {
        directories = [
          config.services.jellyseerr.configDir
        ];
      };
    };
  };
}
