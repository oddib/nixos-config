{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ prismlauncher ];
  #nixpkgs.config.allowBroken = true;
}
