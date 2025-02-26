{ inputs, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      ## /var/lib
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      ## /etc
      "/etc/secureboot"
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
      "/etc/passwords"
    ];
    files = [
      "/etc/machine-id"
      #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };
}

