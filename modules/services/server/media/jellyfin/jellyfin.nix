{
  flake.modules.nixos.jellyfin = {...}: {
    services.jellyfin = {
      enable = true;
      group = "media";
    };
    systemd.services.jellyfin.serviceConfig = {
      SupplementaryGroups = "video render";
    };
  };
}
