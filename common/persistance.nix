{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf mkOption types mkMerge mkDefault;
  cfg = config.system.impermanence;
in {
  options = {
    system.impermanence.enable = mkOption {
      description = "Enable impermanence";
      type = types.bool;
      default = false;
    };
  };
  config = mkMerge [
    (mkIf cfg.enable {
      fileSystems."/persist".neededForBoot = true;
      environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;
        directories = [
          "/var/log"
          ## /var/lib
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          ## /etc
          "/etc/nixos"
          "/etc/NetworkManager/system-connections"
          "/etc/passwords"
        ];
        files = [
          "/etc/machine-id"
          #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
        ];
      };
    })
    {
      environment.persistence."/persist" = {
        enable = mkDefault false;
      };
    }
  ];
}
