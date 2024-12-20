# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, ... }:

{
  # Containers
  imports = [ ./caddy.nix ./opnix.nix ./streamer.nix];
  environment.systemPackages = with pkgs; [ mergerfs ];
  fileSystems = {
    disk1 = {
      device = "/dev/disk/by-uuid/0dd470b5-baec-43bc-bec8-dcf3b44667d9";
      mountPoint = "/mnt/disks/disk1";
      options = ["nofail"];
    };
    disk2 = {
      device = "/dev/disk/by-uuid/183b6cc6-ed56-4f07-b5c2-99d4c32d0703";
      mountPoint = "/mnt/disks/disk2";
      options = ["nofail"];
    };
    disk3 = {
      device = "/dev/disk/by-uuid/e869a0c1-317b-4037-b335-be7c277d88ba";
      mountPoint = "/mnt/disks/disk3";
      options = ["nofail"];
    };
    disk4 = {
      device = "/dev/disk/by-uuid/aaeb22d5-194d-409d-b4e2-9e2c8b65aae9";
      mountPoint = "/mnt/disks/disk4";
      options = ["nofail"];
    };
    "/persist/storage" = {
      device = "/mnt/disks/*";
      fsType = "mergerfs";
      options =
        [ "cache.files=partial" "dropcacheonclose=true" "category.create=mfs" ];
    };
  };
  users.users.media ={
    group="media";
    isSystemUser=true;
  };
  users.groups = {

  "media"= {};
  };
}
