{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  sharedUserSettings = {
    "extensions.autoUpdate" = true;
    "files.autoSave" = "afterDelay";
    "git.confirmSync" = false;
    "git.enableSmartCommit" = true;
    "git.autofetch" = true;
  };
  sharedExtensions =
    with pkgs.vscode-extensions; [
      tailscale.vscode-tailscale
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "op-vscode";
        publisher = "1Password";
        version = "1.0.5";
        sha256 = "sha256-J7vAK2t6fSjm5i6y3+88aO84ipFwekQkJMD7W3EIWrc=";
      }
    ];
in {
  config = lib.mkIf osConfig.system.desktop.enable {
    programs.vscode = {
      enable = true;
      profiles = {
        default = {
          userSettings = sharedUserSettings;
          extensions = sharedExtensions;
        };

        nix = {
          userSettings = sharedUserSettings // {
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nix.serverSettings" = {
              "nixd" = {
                "formatting" = {
                  "command" = ["alejandra"];
                };
                "options" = {
                  "nixos" = {
                    "expr" = "(builtins.getFlake \"/home/oddbjornmr/nixos-config/flake.nix\").nixosConfigurations.edwin.options";
                  };
                };
              };
            };
          };
          extensions = sharedExtensions ++ (with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
          ]);
        };

        python-dev = {
          userSettings = sharedUserSettings // {
            # Add any Python-specific settings here
          };
          extensions = sharedExtensions ++ (with pkgs.vscode-extensions; [
            ms-python.python
          ]);
        };
      };
    };
  };
}
