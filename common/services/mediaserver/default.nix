{
  lib,
  config,
  #inputs,
  ...
}: let
  inherit (lib) mkIf mkOption types mkDefault;
in {
  imports = [
    ./streamer.nix
    ./arr.nix
  ];

  options = {
    services.mediaserver.enable = mkOption {
      description = "Enable mediaserver";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf config.services.mediaserver.enable {
    services = {
      sonarr.enable = mkDefault true;
      radarr.enable = mkDefault true;
      prowlarr.enable = mkDefault true;
      sabnzbd.enable = mkDefault true;
      jellyfin.enable = mkDefault true;
      jellyseerr.enable = mkDefault true;
    };
    users.users.media = {
      group = "media";
      isSystemUser = true;
    };
    users.groups = {"media" = {};};
  };
}
