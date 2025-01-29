{ ... }: {
  imports = [ ./samsung-galaxybook-extras ];

  services.fprintd.enable = true;  
  hardware.samsung-galaxybook.enable = true;

}
