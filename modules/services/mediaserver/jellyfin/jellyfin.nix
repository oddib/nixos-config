{
  flake.modules.nixos.jellyfin = {...}: {
    services.jellyfin = {
      enable = true;
      group = "media";
    };
    services.caddy.virtualHosts."{$DOMAIN}".extraConfig = ''
      reverse_proxy localhost:8096
    '';
    systemd.services.jellyfin.serviceConfig = {
      SupplementaryGroups = "video render";
    };
    ###
    # Jellyseerr

    services.jellyseerr = {
      enable = true;
    };

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
