{ config, lib, ... }: {
  ###
  # Wizarr
  
  virtualisation.oci-containers.containers."wizarr" = {
    image = "ghcr.io/wizarrrr/wizarr:latest";
    volumes = [ "/var/lib/container//wizarr:/data/database:rw" ];
    ports = [ "5000:5000" "5690:5690" ];
    extraOptions = [ "--network-alias=wizarr" "--network=default-network" ];
    log-driver = "journald";
  };
  systemd.services."podman-wizarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  services.lldap = {
    enable = true;
    environment = {
      LLDAP_JWT_SECRET_FILE = config.opnix.secrets.lldap-secret.path;
    };
    settings = {
      ldap_user_email = "admin@scuffedflix.no";
      ldap_base_dn = "dc=scuffedflix,dc=no";
      http_url = "http://auth.scuffedflix.no";
    };
  };
}
