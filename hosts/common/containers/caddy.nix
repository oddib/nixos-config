{ lib, config, users, ... }: {
  virtualisation.oci-containers.containers.caddy = {
    image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
    #environmentFiles = [config.opnix.secrets.caddy-secret.path];
    extraOptions = [ "--network=host" ];
    
  };
  users.users.caddy = {
    name = "caddy";
    extraGroups = [ "networkmanager" ];
    isSystemUser = true;
    group = "caddy";

  };
  users.groups.caddy = {};
}
