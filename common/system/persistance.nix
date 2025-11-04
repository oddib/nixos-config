{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkDefault;
  cfg = config.roles.impermanence.enable;
in {
  options = {
    roles.impermanence.enable = mkEnableOption "Enable impermanence";
  };
  config = {
    environment.persistence."/persist" = {
      enable = mkDefault cfg;
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
  };
}
