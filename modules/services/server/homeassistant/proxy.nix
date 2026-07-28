{
  flake.modules.nixos.homeassistant = {...}: {
    services.caddy.virtualHosts."home.{$DOMAIN}" = {
      extraConfig = ''
        reverse_proxy localhost:8123
      '';
      serverAliases = [
        "home.local.{$DOMAIN}"
      ];
    };
  };
}
