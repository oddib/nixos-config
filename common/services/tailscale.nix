{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.services.tailscale.enable {
    services.tailscale = {
      openFirewall = true;
    };

    systemd.services.tailscaled.environment = {
      TS_PERMIT_CERT_UID = "caddy";
    };
    environment.persistence."/persist".directories = ["/var/lib/tailscale"];
  };
}
