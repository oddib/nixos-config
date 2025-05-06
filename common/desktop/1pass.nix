{
  lib,
  config,
  ...
}: {
  config = lib.mkMerge [
    (lib.mkIf config.system.desktop.enable {
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
    })
    # Install 1password-cli if no desktop
    {programs._1password.enable = true;}
  ];
}
