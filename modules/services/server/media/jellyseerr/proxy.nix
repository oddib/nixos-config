{
  flake.modules.nixos.jellyseer = {...}: {
    services.caddy.virtualHosts."jellyseerr.{$DOMAIN}" = {
      serverAliases = [
        "jellyserr.{$DOMAIN}"
        "jellyseer.{$DOMAIN}"
        "jellyser.{$DOMAIN}"
        "request.{$DOMAIN}"
      ];
      extraConfig = ''
        reverse_proxy localhost:5055
      '';
    };
  };
}
