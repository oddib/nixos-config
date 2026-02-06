{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = ["oddbjornmr"];
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };

  flake.modules.darwin.ssh = {
    services.openssh = {
      enable = true;
    };
  };
}
