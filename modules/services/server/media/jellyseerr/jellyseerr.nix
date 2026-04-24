{
  flake.modules.nixos.jellyseerr = {...}: {
    services.seerr = {
      enable = true;
      configDir = "/var/lib/jellyseerr";
    };
  };
}
