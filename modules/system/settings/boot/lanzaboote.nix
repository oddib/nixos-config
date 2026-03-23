{inputs, ...}: {
  flake.modules.nixos.secureboot = {
    lib,
    pkgs,
    ...
  }: {
    imports = with inputs.self.modules.nixos; [
      systemd-boot
    ];
    boot = {
      loader.systemd-boot.enable = lib.mkForce false;
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        autoGenerateKeys.enable = true;
        autoEnrollKeys = {
          enable = true;
          # Automatically reboot to enroll the keys in the firmware
          autoReboot = true;
        };
      };
    };
    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
