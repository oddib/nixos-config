{pkgs, ...}: {
  virtualisation.docker.enable = true;

  # Create required directories with correct permissions
  # Create system user for Odoo
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      odoo = {
        image = "odoo:latest";
        ports = [
          "8069:8069"
        ];
        environment = {
          HOST = "db";
          USER = "odoo";
          PASSWORD = "odoo";
        };
        dependsOn = ["db"];
        extraOptions = [
          "--network=odoo-network"
        ];
      };

      db = {
        image = "postgres:15";
        environment = {
          POSTGRES_DB = "postgres";
          POSTGRES_PASSWORD = "odoo";
          POSTGRES_USER = "odoo";
        };
        extraOptions = [
          "--network=odoo-network"
        ];
      };
    };
  };

  # Create Docker network
  systemd.services.odoo-network = {
    description = "Create Docker network for Odoo";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.docker}/bin/docker network inspect odoo-network >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create odoo-network
    '';
    after = ["docker.service"];
    before = ["docker-odoo.service" "docker-db.service"];
    wantedBy = ["multi-user.target"];
  };
  services.caddy.virtualHosts."scuffedflix.wild-manta.ts.net".extraConfig = ''
    reverse_proxy localhost:8069
  '';

  # Initialize Odoo configuration
}
