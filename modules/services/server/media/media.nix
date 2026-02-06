{inputs, ...}: {

  flake.modules.nixos.media = {
    imports = with inputs.self.modules.nixos; [
      jellyfin
      jellyseerr
      profilarr
      prowlarr
      radarr
      sonarr
      wizarr
      sabnzbd
      harden
    ];
    users.users.media = {
      group = "media";
      isSystemUser = true;
    };
    users.groups = {"media" = {};};
  };
}
