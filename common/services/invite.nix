{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.services.mediaserver.enable {
    virtualisation.oci-containers.containers."wizarr" = {
      image = "ghcr.io/wizarrrr/wizarr:latest";
      volumes = ["/var/lib/container//wizarr:/data/database:rw"];
      ports = ["5000:5000" "5690:5690"];
      extraOptions = ["--network=host"];
      log-driver = "journald";
    };
    services.caddy.virtualHosts."invite.{$DOMAIN}".extraConfig = ''
      reverse_proxy localhost:5690
    '';
  };
}
