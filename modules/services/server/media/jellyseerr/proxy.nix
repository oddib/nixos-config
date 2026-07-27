{
  flake.modules.nixos.jellyseerr = {...}: {
    services.caddy.virtualHosts."jellyseerr.{$DOMAIN}" = {
      serverAliases = [
        "jellyserr.{$DOMAIN}"
        "jellyseer.{$DOMAIN}"
        "jellyser.{$DOMAIN}"
        "request.{$DOMAIN}"
        "requests.{$DOMAIN}"
        "seerr.{$DOMAIN}"
        "serr.{$DOMAIN}"
        "seer.{$DOMAIN}"
        "seerr.local.{$DOMAIN}"
      ];
      extraConfig = ''
        reverse_proxy localhost:5055
      '';
    };
  };
}
