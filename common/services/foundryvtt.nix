{ inputs, pkgs, ... }: {
  imports = [ inputs.foundryvtt.nixosModules.foundryvtt ];
  services.foundryvtt = {
    enable = true;
    minifyStaticFiles = true;
    proxyPort = 443;
    proxySSL = true;
    upnp = false;
    package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
  };

  # opnix = {
  #   systemdWantedBy = [ "podman-foundryvtt" ];
  #   secrets.foundry-secret = {
  #     source = ''
  #       FOUNDRY_ADMIN_KEY=op://Docker secrets/foundryvtt.com/add more/admin_key
  #       FOUNDRY_PASSWORD=op://Docker secrets/foundryvtt.com/password
  #       FOUNDRY_USERNAME=op://Docker secrets/foundryvtt.com/username
  #       '';
  #     symlink = true;
  #     user = "media";
  #     group = "media";
  #     mode = "0600";
  #   };
  # };
  # virtualisation.oci-containers.containers."foundryvtt" = {
  #   image = "felddy/foundryvtt:release";
  #   environmentFiles = [ config.opnix.secrets.foundry-secret.path ];
  #   environment = { 
  #     "CONTAINER_VERBOSE" = "true"; 
  #     "FOUNDRY_GID" = "984";
  #     "FOUNDRY_UID" = "987";
  #     "CONTAINER_CACHE" = "/data/cache";
  #   };
  #   user = "987:984";
  #   volumes = [
  #   #  "/var/lib/container/foundryvtt:/data:rw"
  #   ];
  #   #ports = [ "30000:30000" ];
  #   extraOptions = [ "--network=host" ];
  # };
}
