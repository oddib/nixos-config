{ inputs, ... }: {
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  environment.persistence."/persist" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      ## /var/lib
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/flatpak"
      "/var/lib/tailscale"
      "/var/lib/sbctl"
      ## /etc
      "/etc/secureboot"
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
      #{ file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
  };
}

