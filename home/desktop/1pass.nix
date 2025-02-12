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
}
