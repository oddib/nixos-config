{lib,inputs,pkgs, ...}:
let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  modpack = pkgs.fetchPackwizModpack {
    url = "https://github.com/oddib/oddpack/blob/main/pack.toml";
    packHash = "sha256-L5RiSktqtSQBDecVfGj1iDaXV+E90zrNEcf4jtsg+wk=";
  };
  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings [ "." ] [ "_" ] "fabric-${mcVersion}";

in
{
  services.minecraft-servers.servers.oddpack = {
    enable = true;
    package = pkgs.fabricServers.${serverVersion}.override { loaderVersion = fabricVersion; };
    symlinks = collectFilesAt modpack "mods" ;
    files = collectFilesAt modpack "config";
  };
}

