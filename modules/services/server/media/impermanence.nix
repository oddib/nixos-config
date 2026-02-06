{inputs, ...}: {
  flake.modules.nixos.arr = {config, ...}: {
    environment = inputs.self.lib.mkIfPersistence config {
      persistence."/persist" = {
        # files = [
        #   {
        #     file = config.services.sabnzbd.secretFiles;
        #     user = config.services.sabnzbd.user;
        #     group = config.services.sabnzbd.group;
        #     parentDirectory = {
        #       mode = "u=rwx,g=,o=";
        #     };
        #   }
        # ];
        directories = [
          config.services.radarr.dataDir
          config.services.sonarr.dataDir
          config.services.prowlarr.dataDir
          "/var/lib/container/profilarr"
          "/var/lib/container/wizarr"
        ];
      };
    };
  };
}
