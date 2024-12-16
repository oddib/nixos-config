# Auto-generated using compose2nix v0.3.2-pre.
{ pkgs, ... }:

{
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

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

  virtualisation.oci-containers.backend = "podman";

  # Containers
  imports = [
    ./arr.nix
    ./auth.nix
    ./db.nix
    ./proxy.nix
    ./streamer.nix
    ./utilities.nix
  ];
  # Networks
  systemd.services."podman-network-default-network" = {
    path = [ pkgs.podman ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "podman network rm -f default-network";
    };
    script = ''
      podman network inspect default-network || podman network create default-network --driver=bridge
    '';
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-scuffedflix-root" = {
    unitConfig = { Description = "Root target generated by compose2nix."; };
    wantedBy = [ "multi-user.target" ];
  };
}
