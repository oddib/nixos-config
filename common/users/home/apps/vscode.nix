{
  osConfig,
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
  sharedExtensions = with pkgs.vscode-extensions;
    [
      jnoortheen.nix-ide
      mkhl.direnv
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-sqlite";
        publisher = "alexcvzz";
        version = "0.14.1";
        sha256 = "sha256-jOQkRgBkUwJupD+cRo/KRahFRs82X3K49DySw6GlU8U=";
      }
      /*
         {
        name = "op-vscode";
        publisher = "1Password";
        version = "1.0.5";
        sha256 = "sha256-J7vAK2t6fSjm5i6y3+88aO84ipFwekQkJMD7W3EIWrc=";
      }
      */
    ];
in {
  programs.vscode = {
    enable = osConfig.roles.desktop.enable;
    profiles = {
      default = {
        userSettings = sharedUserSettings;
        extensions = sharedExtensions;
      };

      nix = {
        userSettings =
          sharedUserSettings
          // {
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
        extensions =
          sharedExtensions;
      };

      rust-dev = {
        userSettings =
          sharedUserSettings
          // {
          };
        extensions =
          sharedExtensions
          ++ (
            with pkgs.vscode-extensions; [
              rust-lang.rust-analyzer
            ]
          );
      };
      python-dev = {
        userSettings =
          sharedUserSettings
          // {
          };
        extensions =
          sharedExtensions
          ++ (
            with pkgs.vscode-extensions; [
              ms-python.python
              ms-toolsai.jupyter
            ]
          );
      };
    };
  };
}
