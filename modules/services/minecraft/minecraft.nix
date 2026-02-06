{
  flake.modules.nixos.minecraft = {...}:
  # Make sure the flake inputs are in your system's config
  {
    services.minecraft-servers = {
      enable = true;
      eula = true;
      managementSystem = {
        tmux.enable = false;
        systemd-socket.enable = true;
      };
      dataDir = "/var/lib/minecraft";
    };
  };
}
