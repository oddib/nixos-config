{ lib, inputs, pkgs, ... }:

let

  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/oddib/oddpack/main/pack.toml";
    packHash = "sha256-+jAH2ErxOCAPKvH48PR2gGOnXNFgmFQyEftT6v9JGxQ=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";
in {
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];
  services.minecraft-servers = {
    enable = true;
    eula = true;
    managementSystem = {
      tmux.enable = false;
      systemd-socket.enable = true;
    };

    servers.oddpack = {
      enable = true;
      package = pkgs.fabricServers.${serverVersion}.override {
        loaderVersion = fabricVersion;
      };
      symlinks = collectFilesAt modpack "mods";
      files = collectFilesAt modpack "config";
    };
  };
}

