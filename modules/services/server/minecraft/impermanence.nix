{inputs, ...}: {
  flake.modules.nixos.minecraft = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          config.services.minecraft-servers.dataDir
        ];
      };
    };
  };
}
