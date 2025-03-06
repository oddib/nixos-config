{ pkgs, lib, config, ... }: {
  config = lib.mkMerge [
    (lib.mkIf config.system.desktop.enable {
      programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "oddbjornmr" ];
      };
      environment.etc = {
        "1password/custom_allowed_browsers" = {
          text = ''
            vivaldi-bin
          '';
          mode = "0755";
        };
      };
      home-manager.users.oddbjornmr.programs = {
        ssh = {
          enable = true;
          extraConfig = ''
            Host *
                IdentityAgent ~/.1password/agent.sock
          '';
        };
        git = {
          enable = true;
          userName = "Oddbjørn Rønnestad";
          userEmail = "60390653+oddib@users.noreply.github.com";
          extraConfig = {
            gpg = { format = "ssh"; };
            "gpg \"ssh\"" = {
              program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
            };
            commit = { gpgsign = true; };

            user = {
              signingKey =
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDCJ0s4kA8stxlBhrxhyN1bQyBh8LFE+HsoNZbas83V";
            };
          };
        };
      };
    })
    # Install 1password-cli if no desktop
    { programs._1password.enable = true; }
  ];
}
