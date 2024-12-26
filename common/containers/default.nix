{ ... }:

{
  # Containers
  imports = [ ./caddy.nix ./opnix.nix ./streamer.nix ./auth.nix ./arr.nix];
  users.users.media ={
    group="media";
    isSystemUser=true;
  };
  users.groups = {

  "media"= {};
  };

}
