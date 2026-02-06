{
  inputs,
  ...
}:
{
  flake.modules.nixos.bluetooth =
    { config, ... }:
    {
      environment = inputs.self.lib.mkIfPersistence config {
        persistence."/persist" = {
          directories = [
            "/var/lib/bluetooth"
          ];
        };
      };
    };
}
