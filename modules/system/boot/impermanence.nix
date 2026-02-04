{
  flake.modules.nixos.secureboot = {config, ...}: {
    environment = {
      persistence."/persist".directories = [config.boot.lanzaboote.pkiBundle];
    };
  };
}
