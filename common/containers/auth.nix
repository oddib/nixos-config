{ lib, ... }: {
  virtualisation.oci-containers.containers."wizarr" = {
    image = "ghcr.io/wizarrrr/wizarr:latest";
    volumes = [ "/var/lib/container//wizarr:/data/database:rw" ];
    ports = [ "5000:5000" "5690:5690" ];
    extraOptions = [ "--network-alias=wizarr" "--network=default-network" ];
  };
  systemd.services."podman-wizarr" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
}
