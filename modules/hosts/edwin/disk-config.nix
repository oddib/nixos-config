{
  flake.modules.nixos.edwin = {
    pkgs,
    lib,
    ...
  }: {
    environment.systemPackages = with pkgs; [mergerfs];
    swapDevices = [{device = "/dev/disk/by-uuid/05dfc96e-c67f-45af-a5f1-9568e5005a9c";}];

    fileSystems = let
      # Define your storage disks here to avoid repetition.
      # To add/remove a disk, just change this list.
      storageDisks = {
        disk1 = "0dd470b5-baec-43bc-bec8-dcf3b44667d9";
        disk2 = "183b6cc6-ed56-4f07-b5c2-99d4c32d0703";
        disk3 = "e869a0c1-317b-4037-b335-be7c277d88ba";
        disk4 = "aaeb22d5-194d-409d-b4e2-9e2c8b65aae9";
      };
      # Automatically generate the mount configuration for each storage disk.
      storageDiskMounts = lib.mapAttrs' (name: value:
        lib.nameValuePair ("/mnt/disks/" + name) {
          device = "/dev/disk/by-uuid/" + value;
          fsType = "auto";
          options = ["nofail"];
        })
      storageDisks;
    in
      storageDiskMounts
      // {
        "/" = {
          device = "/dev/disk/by-uuid/b2419630-73e6-4aef-a2d1-d086f513b726";
          fsType = "btrfs";
        };
        "/boot" = {
          device = "/dev/disk/by-uuid/E2C0-442A";
          fsType = "vfat";
          options = ["fmask=0077" "dmask=0077"];
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
  };
}
