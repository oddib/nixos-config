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
}
