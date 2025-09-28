/*
   {
  users.mutableUsers = false;
  users.users.oddbjornmr = {
    isNormalUser = true;
    description = "Oddbjørn Mestad Rønnestad";
    extraGroups = ["networkmanager" "wheel" "lpadmin"];
    hashedPasswordFile = "/etc/passwords/oddbjornmr";
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs.flake-inputs = inputs;
    backupFileExtension = "hm-backup";
  };
  home-manager = {
    users.oddbjornmr = import ./home;
  };
}
*/
{
  inputs,
  lib,
  config,
  allUsers,
  ...
}: let
  cfg = config.roles.users;

  # Filter DB to only keep enabled users for this host
  hostUsers = lib.filterAttrs (n: _: builtins.elem n cfg) allUsers;

  hmUsers = lib.filterAttrs (_: v: v != null) (
    lib.mapAttrs (
      name: uCfg:
        if uCfg.useHM
        then {
          home.username = name;
          home.homeDirectory = "/home/${name}";
          imports = [
            (
              if builtins.pathExists (./home + "/${name}.nix")
              then ./home + "/${name}.nix"
              else ./home/default.nix
            )
          ];
        }
        else null
    )
    hostUsers
  );
in {
  imports = [
    ./accounts.nix
  ];
  options.roles.users = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [];
    description = "List of usernames to enable on this host";
  };
  config = {
    users.mutableUsers = false;

    users.users =
      lib.mapAttrs
      (name: uCfg: {
        isNormalUser = true;
        home = "/home/${name}";
        description = uCfg.description;
        extraGroups = uCfg.groups;
        shell = uCfg.shell;
        hashedPasswordFile = "/etc/passwords/${name}";
      })
      hostUsers;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs.flake-inputs = inputs;
      backupFileExtension = "hm-backup";
      users = lib.filterAttrs (_: v: v != null) hmUsers;
    };
  };
}
