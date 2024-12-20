# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, ... }:

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
