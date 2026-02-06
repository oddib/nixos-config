{inputs, ...}: {
  flake.modules.nixos.caddy = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          "/var/lib/caddy"
        ];
      };
    };
  };
}
