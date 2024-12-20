{ ... }:

{
  # Containers
  imports = [ ./caddy.nix ./opnix.nix ./streamer.nix];
  users.users.media ={
    group="media";
    isSystemUser=true;
  };
  users.groups = {

  "media"= {};
  };
}
