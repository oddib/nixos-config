{inputs, ...}: {
  # expansion of cli system for server use

  flake.modules.nixos.server = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      caddy
      arr
      jellyfin
      foundryvtt
      minecraft
    ];
    users.users.media = {
      group = "media";
      isSystemUser = true;
    };
    users.groups = {"media" = {};};
  };
}
