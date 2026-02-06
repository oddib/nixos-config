{
  flake.modules.nixos.onepass = {...}: {
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = ["oddbjornmr"];
    };
    environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          vivaldi-bin
        '';
        mode = "0755";
      };
    };
  };
  flake.modules.homeManager.onepass = {
    lib,
    pkgs,
    ...
  }: let
    # onePassPath = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    onePassPath = "~/.1password/agent.sock";
  in {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ${onePassPath}
      '';
    };
    programs.git.settings = {
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      commit.gpgsign = true;
    };
  };
}
