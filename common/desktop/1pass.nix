{ ... }:

{
  # Install 1password
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
      '';
      mode = "0755";
    };
  };
  nixpkgs = {
    overlays = [
      (final: prev: {
        _1password-gui = prev._1password-gui.override {
          polkitPolicyOwners = [ "oddbjornmr" ];
        };
      })
    ];
  };
  home-manager.users.oddbjornmr = {
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}
