{ ... }: {
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
  environment.persistence."/persist".directories = [ "/var/lib/tailscale" ];
}
