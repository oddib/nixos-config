{ osConfig, lib, pkgs, ... }: {
  config = lib.mkIf osConfig.system.desktop.enable {
    programs.vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          "extensions.autoUpdate" = false;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nil";
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "files.autoSave" = "afterDelay";
          "git.autofetch" = true;
          "nix.serverSettings" = {
            "nil" = {
              "formatting" = { "command" = [ "nixfmt" ]; };
            };
          };
        };
        extensions = with pkgs.vscode-extensions;
          [
            jnoortheen.nix-ide
            # ms-python.python
            ms-azuretools.vscode-docker
            # ms-vscode-remote.remote-ssh
            tailscale.vscode-tailscale

          ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
            name = "op-vscode";
            publisher = "1Password";
            version = "1.0.5";
            sha256 = "sha256-J7vAK2t6fSjm5i6y3+88aO84ipFwekQkJMD7W3EIWrc=";
          }];
      };
    };
  };
}
