{pkgs, ... }:

{
  imports = [ ./1pass.nix ./tailscale.nix ];
  home-manager.backupFileExtension = "hm-backup";

  # Enable networking
  networking.networkmanager.enable = true;
  # Enabling flakes and unfree
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  # Select internationalisation properties.
  i18n.defaultLocale = "nb_NO.UTF-8";
  # Configure console keymap
  console.keyMap = "no";
  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
      duplicacy
    ];
  users.users.oddbjornmr = {
    isNormalUser = true;
    description = "Oddbjørn Mestad Rønnestad";
    extraGroups = [ "networkmanager" "wheel" ];
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.oddbjornmr = import ../home-manager/default.nix;
  };
}
