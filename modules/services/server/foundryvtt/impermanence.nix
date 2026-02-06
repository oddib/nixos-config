{inputs, ...}: {
  flake.modules.nixos.foundryvtt = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persistent" = {
        directories = [
          "/var/lib/foundryvtt"
        ];
      };
    };
  };
}
