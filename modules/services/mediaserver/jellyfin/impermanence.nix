{inputs, ...}: {
  flake.modules.nixos.jellyfin = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persistent" = {
        directories = [
          "/var/lib/jellyseerr"
          "/var/lib/jellyfin"
        ];
      };
    };
  };
}
