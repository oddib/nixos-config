{ ... }: {
  imports= [
    #inputs.nixos-jellyfin.nixosModules.jellyfin
  ];
  ###
  # Jellyfin

  services.jellyfin = {
    enable = true;
    group = "media";
  };
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
}

