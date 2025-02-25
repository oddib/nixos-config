{
  services.nix-serve = {
    enable = true;
    secretKeyFile = "/var/cache-priv-key.pem";
    port = 8081;
  };
  environment.persistence."/persist".files =
    [{ file = "/var/cache-priv-key.pem"; }];

}
