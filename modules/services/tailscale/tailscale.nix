{
  flake.modules.nixos.tailscale = {...}: {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };

    systemd.services.tailscaled.environment = {
      TS_PERMIT_CERT_UID = "caddy";
    };
  };
}
