{
  lib,
  config,
  #inputs,
  ...
}: let
  inherit (lib) mkIf mkDefault;
in {
  imports = [
    ./streamer.nix
    ./arr.nix
    ./wizarr.nix
  ];
  config = mkIf config.roles.server.mediaserver.enable {
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
    virtualisation.docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      enable = true;
      autoPrune.enable = true;
      storageDriver = "btrfs";
    };
    virtualisation.oci-containers.backend = "docker";
  };
}
