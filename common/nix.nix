{
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    substituters = ["https://cache.nixos.org/" "https://nixcache.scuffedflix.no"];
    trusted-public-keys = [
      "nixcache.scuffedflix.no:GtnH8sPYpKYcIaQSfc92UD02uG9OG//h2qOuBPgoI1w="
    ];
  };
}
