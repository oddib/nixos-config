{pkgs,...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disk-config.nix
  ];
  system = {
    desktop.enable = true;
    services.enable = true;
    games.enable = true;
  };
  programs.corectrl.enable = true;
  environment.systemPackages = with pkgs; [
    (caddy.withPlugins {
        plugins = [
          "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e"
          "github.com/greenpau/caddy-security@v1.1.31"
          "github.com/abiosoft/caddy-exec@v0.0.0-20240914124740-521d8736cb4d"
        ];
        hash = "sha256-NWIThHIGOAr8/VUq5yaZ+ZHwX+WSBFEIAwds2ti5M/c=";
      })
  ];
  # Networking
  networking.hostName = "edwin";

  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
