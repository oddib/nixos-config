{inputs, ...}: {
  flake.modules.nixos.profilarr = {...}: {
    imports = with inputs.self.modules.nixos; [
      containers
    ];
    virtualisation.oci-containers.containers."profilarr" = {
      image = "santiagosayshey/profilarr:latest";
      volumes = ["/var/lib/container/profilarr:/config:rw"];
      ports = ["6868:6860"];
      extraOptions = ["--network=host"];
      log-driver = "journald";
      environment = {
      };
    };
    services.caddy.virtualHosts."profilarr.{$DOMAIN}".extraConfig = ''
      route {
        import auth
        @allowedUser {
          header X-Webauth-User "{$EMAIL}"
        }
        reverse_proxy @allowedUser http://localhost:6868
        respond "Access denied" 403
      }
    '';
  };
}
