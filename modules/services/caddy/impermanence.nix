{inputs, ...}: {
  flake.modules.nixos.caddy = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persistent" = {
        directories = [
          "/var/lib/caddy"
        ];
      };
    };
  };
}
