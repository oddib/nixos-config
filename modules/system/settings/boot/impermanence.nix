{inputs, ...}: {
  flake.modules.nixos.secureboot = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [config.boot.lanzaboote.pkiBundle];
      };
    };
  };
}
