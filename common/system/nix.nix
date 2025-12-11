{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      #substituters = ["https://cache.nixos.org/" "https://nixcache.scuffedflix.no"];
      #trusted-public-keys = [
      #  "nixcache.scuffedflix.no:GtnH8sPYpKYcIaQSfc92UD02uG9OG//h2qOuBPgoI1w="
      #];
    };
    extraOptions = ''
      extra-substituters = https://devenv.cachix.org
      extra-trusted-public-keys = devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=
    '';
  };
}
