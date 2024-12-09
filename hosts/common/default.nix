{ config, pkgs, ... }:

{
  imports =
    [ ./1pass.nix
      ./tailscale.nix
    ];
}
