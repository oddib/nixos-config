{pkgs, ...}: {
  environment.systemPackages = with pkgs; [mergerfs];
  swapDevices = [{device = "/dev/disk/by-uuid/05dfc96e-c67f-45af-a5f1-9568e5005a9c";}];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b2419630-73e6-4aef-a2d1-d086f513b726";
      fsType = "btrfs";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/E2C0-442A";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
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
    data = {
      device = "/dev/disk/by-label/Data";
      mountPoint = "/mnt/data";
      options = ["nofail"];
    };
    "/media" = {
      device = "/mnt/disks/*";
      fsType = "mergerfs";
      options = ["cache.files=partial" "dropcacheonclose=true" "category.create=mfs"];
    };
    "/srv" = {
      device = "/mnt/disks/*:/mnt/data/data";
      fsType = "mergerfs";
      options = ["cache.files=partial" "dropcacheonclose=true" "category.create=lus"];
    };
  };
}
