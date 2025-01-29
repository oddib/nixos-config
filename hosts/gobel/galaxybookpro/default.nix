{ ... }: {
  imports = [ ./samsung-galaxybook-extras ];

  services.fprintd.enable = true;
  hardware.samsung-galaxybook.enable = true;
  boot.kernelParams = [ "i915.enable_dpcd_backlight=3" ];
}
