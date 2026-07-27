{
  flake.modules.nixos.jellyfin = {...}: {
    services.caddy.virtualHosts."{$DOMAIN}" = {
      extraConfig = ''
        reverse_proxy localhost:8096
      '';
      serverAliases = [
        "jellyfin.{$DOMAIN}"
        "local.{$DOMAIN}"
      ];
    };
  };
}
