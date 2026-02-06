{
  flake.modules.nixos.secureboot = {
    lib,
    pkgs,
    inputs,
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
      };
    };
    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
