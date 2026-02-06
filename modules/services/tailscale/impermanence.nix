{inputs, ...}: {
  flake.modules.nixos.tailscale = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        directories = [
          "/var/lib/tailscale"
        ];
      };
    };
  };
}
