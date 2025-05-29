{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.system.desktop.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        #/home/oddbjornmr/nixos/flake.nix
        userSettings = {
          "extensions.autoUpdate" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "files.autoSave" = "afterDelay";
          "git.autofetch" = true;
          "nix.serverSettings" = {
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"/home/oddbjornmr/nixos/flake.nix\").nixosConfigurations.edwin.options";
              };
            };
            "nixd" = {
              "formatting" = {
                "command" = ["alejandra"];
              };
            };
          };
        };
        extensions = with pkgs.vscode-extensions;
          [
            jnoortheen.nix-ide
            # ms-python.python
            # ms-azuretools.vscode-docker
            # ms-vscode-remote.remote-ssh
            tailscale.vscode-tailscale
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "op-vscode";
              publisher = "1Password";
              version = "1.0.5";
              sha256 = "sha256-J7vAK2t6fSjm5i6y3+88aO84ipFwekQkJMD7W3EIWrc=";
            }
          ];
      };
    };
  };
}
