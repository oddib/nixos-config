{pkgs,lib,...}:
{
    programs.git = {
    enable = true;
    userName = "Oddbjørn Rønnestad";
    userEmail = "60390653+oddib@users.noreply.github.com";
    extraConfig = {
      gpg = { format = "ssh"; };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = { gpgsign = true; };

      user = { signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDCJ0s4kA8stxlBhrxhyN1bQyBh8LFE+HsoNZbas83V"; };
    };
  };
}