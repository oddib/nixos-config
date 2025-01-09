{pkgs, ...}:
let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://github.com/Misterio77/Modpack/raw/0.2.9/pack.toml";
    packHash = "sha256-L5RiSktqtSQBDecVfGj1iDaXV+E90zrNEcf4jtsg+wk=";
  };
in
{
  services.minecraft-servers.servers.cool-modpack = {
    enable = true;
    package = pkgs.fabricServers.fabric-1_18_2.override { loaderVersion = "0.14.9"; };
    symlinks = {
      "mods" = "${modpack}/mods";
    };
    files = {
      "config" = "${modpack}/config";
      "config/mod1.yml" = "${modpack}/config/mod1.yml";
      "config/mod2.conf" = "${modpack}/config/mod2.conf";
      # You can add files not on the modpack, of course
      "config/server-specific.conf".value = {
        example = "foo-bar";
      };
    };
  };
}

