{ config, pkgs, ... }:

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
}