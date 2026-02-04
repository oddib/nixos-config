{
  flake.modules.nixos.arr = {config, ...}: {
    environment.persistence."/persist" = {
      files = [
        {
          file = config.services.sabnzbd.configFile;
          user = config.services.sabnzbd.user;
          group = config.services.sabnzbd.group;
          parentDirectory = {
            mode = "u=rwx,g=,o=";
          };
        }
      ];
      directories = [
        config.services.radarr.dataDir
        config.services.sonarr.dataDir
        config.services.prowlarr.dataDir
      ];
    };
  };
}
