{ pkgs, ... }: {
  # Containers
  imports = [
    ./caddy.nix
    #./opnix.nix
    #inputs.opnix.nixosModules.default
    ./streamer.nix
    ./auth.nix
    ./arr.nix
    ./foundryvtt.nix
    ./minecraft
  ];
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      # Required for container networking to be able to use names.
      dns_enabled = true;
    };
  };
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];
  virtualisation.oci-containers.backend = "podman";
  ###
  # Create standard user (unused)
  users.users.media = {
    group = "media";
    isSystemUser = true;
  };
  users.groups = { "media" = { }; };

  ###
  # Set up service for configuring network
  systemd.services."podman-network-default-network" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f default-network";
    };
    script = ''
      podman network inspect default-network || podman network create default-network --driver=bridge --subnet=10.0.1.0/24
    '';
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  ###
  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-scuffedflix-root" = {
    unitConfig = { Description = "Root target generated by compose2nix."; };
    #wantedBy = [ "multi-user.target" ];
  };
}
