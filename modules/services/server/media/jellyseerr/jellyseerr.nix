{
  flake.modules.nixos.jellyseerr = {...}: {
    services.jellyseerr = {
      enable = true;
    };
  };
}
