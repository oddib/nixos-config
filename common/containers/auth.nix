{ ... }: {
  virtualisation.oci-containers.containers."wizarr" = {
    image = "ghcr.io/wizarrrr/wizarr:latest";
    volumes = [ "/var/lib/container//wizarr:/data/database:rw" ];
    ports = [ "5690:5690" ];

  };
}
