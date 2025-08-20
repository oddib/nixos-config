{
  lib,
  config,
  ...
}:  let
  inherit (lib) mkIf mkOption types mkDefault;
in{
  options={
    services.mylar3.enable =lib.mkOption {
      description = "Enable server-configuration";
      type = types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.services.mylar3.enable {
    virtualisation.oci-containers.containers."mylar3" = {
      image = "lscr.io/linuxserver/mylar3:latest";
      volumes = ["/var/lib/container/mylar3:/config:rw" "/srv/comics/:/comics" "/srv/download/comics:/downloads"];
      ports = ["8090:8090"];
      extraOptions = ["--network=host"];
      log-driver = "journald";
      
    };
    services.caddy.virtualHosts."mylar.{$DOMAIN}".extraConfig = ''
      reverse_proxy localhost:8090
    '';
    environment.persistence."/persist".directories =
      [ "/var/lib/container/mylar3" ];

  };
}
