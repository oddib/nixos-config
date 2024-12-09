{ config, pkgs, ... }:

{
  # Install 1passwordhttps://wiki.nixos.org/wiki/Tailscale
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
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
}