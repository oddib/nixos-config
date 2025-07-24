{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkOption types mkMerge mkDefault;
in {
  imports = [./de ./games.nix ./1pass.nix ./sunshine.nix];
  options = {
    system.desktop = {
      enable = mkOption {
        description = "enable desktop";
        type = types.bool;
        default = false;
      };
      games.enable = mkOption {
        description = "enable game launchers";
        type = types.bool;
        default = false;
      };
    };
  };
  config = mkMerge [
    (
      mkIf config.system.desktop.enable {
        programs = {
          _1password.enable = true;
          _1password-gui.enable = true;
        };
        # Enable CUPS to print documents.
        services.printing.enable = mkDefault true;
        services.avahi = {
          enable = mkDefault true;
        };

        # Bluetooth
        hardware.bluetooth = {
          enable = true; # enables support for Bluetooth
          powerOnBoot = false; # powers up the default Bluetooth controller on boot
          settings.General.Enable = "Source,Sink,Media,Socket"; # Enabling A2DP Sink
          # settings.General.Experimental =true; # Showing battery charge of bluetooth devices
        };
        services.flatpak.enable = true;
      }
    )
    ## Games

    (mkIf config.system.desktop.games.enable {
      environment.systemPackages = [
        pkgs.moonlight-qt
      ];

      programs = {
        steam.enable = true;
        gamemode.enable = true;
        # gamescope.enable = true;
      };
    })
  ];
}
