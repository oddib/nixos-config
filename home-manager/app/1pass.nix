{ pkgs, lib, ... }:

{
  nixpkgs = {
    overlays = [
      (final: prev: {
        _1password-gui = prev._1password-gui.override {
          polkitPolicyOwners = [ "oddbjornmr" ];
        };
      })
    ];
  };
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ~/.1password/agent.sock
    '';
  };
  programs.git = {
    enable = true;
    extraConfig = {
      gpg = { format = "ssh"; };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = { gpgsign = true; };

      user = { signingKey = "..."; };
    };
  };
}
