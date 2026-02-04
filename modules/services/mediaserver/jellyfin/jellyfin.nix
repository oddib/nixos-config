{
  flake.modules.nixos.jellyfin=
    {...}: {
  # Jellyfin

  services.jellyfin = {
    group = "media";
  };
  services.caddy.virtualHosts."{$DOMAIN}".extraConfig = ''
    reverse_proxy localhost:8096
  '';
  systemd.services.jellyfin.serviceConfig = {
    SupplementaryGroups = "video render";
    #ReadOnlyPaths="/persist/media/";
  };
  ###
  # Jellyseerr

  services.jellyseerr = {
    #group = "media";
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
  environment.persistence."/persist".directories = ["/var/lib/jellyseerr" "/var/lib/jellyfin"];
}

}