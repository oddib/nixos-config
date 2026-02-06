{
  flake.modules.nixos.jellyfin = {...}: {
    services.caddy.virtualHosts."{$DOMAIN}".extraConfig = ''
      reverse_proxy localhost:8096
    '';
  };
}
