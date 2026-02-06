{inputs, ...}: {
  flake.modules.nixos.foundryvtt = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          "/var/lib/foundryvtt"
        ];
      };
    };
  };
}
