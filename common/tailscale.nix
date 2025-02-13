{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.tailscale ];
  services.tailscale.enable = true;
  services.tailscale.openFirewall = true;
}
