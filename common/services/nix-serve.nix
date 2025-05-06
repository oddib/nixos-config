{
  lib,
  config,
  ...
}: {
  config = lib.mkMerge [
    {
      services.nix-serve = {
        secretKeyFile = "/var/cache-priv-key.pem";
        port = 8081;
      };
    }
    (lib.mkIf config.services.nix-serve.enable {
      services.caddy.virtualHosts."nixcache.{$DOMAIN}".extraConfig = ''
        reverse_proxy localhost:8081
      '';
      environment.persistence."/persist".files = [{file = "/var/cache-priv-key.pem";}];
    })
  ];
}
