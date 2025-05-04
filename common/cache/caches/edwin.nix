{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (!config.services.nix-serve.enable) {
    nix = {
      settings = {
        substituters = ["https://nixcache.scuffedflix.no"];
        trusted-public-keys = [
          "nixcache.scuffedflix.no:GtnH8sPYpKYcIaQSfc92UD02uG9OG//h2qOuBPgoI1w="
        ];
      };
    };
  };
}
