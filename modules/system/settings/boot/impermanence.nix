{
  flake.modules.nixos.secureboot = {config, ...}: {
      environment = inputs.self.lib.mkIfPersistence config {
        persistence."/persistent" = {
directories = [config.boot.lanzaboote.pkiBundle];
    };
  };
};
}
