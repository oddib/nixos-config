{
  flake.modules.nixos.minecraft = {
    lib,
    inputs,
    pkgs,
    ...
  }: let
    inherit (inputs.nix-minecraft.lib) collectFilesAt;
    modpack = pkgs.fetchPackwizModpack {
      url = "https://raw.githubusercontent.com/oddib/oddpack/refs/tags/1.2.0/pack.toml";
      packHash = "sha256-xkJGWIq0hjTvGzZqpMSvO2tD+2PyneCJyT1+4V06FIs=";
    };
    mcVersion = modpack.manifest.versions.minecraft;
    fabricVersion = modpack.manifest.versions.fabric;
    serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
  in {
    services.minecraft-servers = {
      servers.oddpack = {
        enable = false;
        package = pkgs.fabricServers.${serverVersion}.override {
          loaderVersion = fabricVersion;
        };
        symlinks = collectFilesAt modpack "mods";
        files = collectFilesAt modpack "config";
      };
    };
  };
}
