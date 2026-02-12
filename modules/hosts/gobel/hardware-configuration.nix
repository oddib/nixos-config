{lib,...}: {
  flake.modules.nixos.gobel = {...}: {
    hardware.facter.reportPath = ./facter.json;
    hardware.facter.detected.dhcp.enable = lib.mkForce false;
    boot.kernelParams = ["i915.enable_dpcd_backlight=3"];
  };
}
