{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.services.mediaserver;
in {
  config = mkIf cfg.enable {
    ###
    # Jellyfin

    services.jellyfin = {
      enable = true;
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
      enable = true;
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
  };
}
