{ ... }: {
  # Containers
  imports = [ ./caddy.nix ./opnix.nix ./streamer.nix ./auth.nix ./arr.nix ];
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
  users.users.media = {
    group = "media";
    isSystemUser = true;
  };
  users.groups = { "media" = { }; };
}
