{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.programs._1password-gui.enable {
    programs._1password-gui = {
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
