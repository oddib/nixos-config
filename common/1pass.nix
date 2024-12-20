{ ... }:

{
  # Install 1password
  programs._1password.enable = true;
  programs._1password-gui = { enable = true; };
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
      '';
      mode = "0755";
    };
  };
}
