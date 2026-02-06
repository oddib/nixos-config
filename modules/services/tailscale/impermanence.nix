{inputs, ...}: {
  flake.modules.nixos.tailscale = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persistent" = {
        directories = [
          "/var/lib/tailscale"
        ];
      };
    };
  };
}
