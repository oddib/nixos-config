{
  inputs,
  pkgs,
  ...
}: let
  defuser = "oddbjornmr";
in {
  imports = [
    ./tailscale.nix
    ./nix.nix
    ./boot.nix
    ./services
    ./desktop
    ./persistance.nix
  ];

  # Enable networking
  networking.networkmanager.enable = true;
  # Enabling flakes and unfree
  nixpkgs.config.allowUnfree = true;

  services.fwupd.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "nb_NO.UTF-8";
    /*
       extraLocales = [
    "nn_NO.UTF-8"
    "en_US.UTF-8"
    "en_GB.UTF-8"];
    */
  };
  ## Configure console keymap
  console.keyMap = "no";
  environment.systemPackages = with pkgs; [
    #  vim
    #  wget
    duplicacy
  ];
  services.tailscale.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = [defuser];
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  users.mutableUsers = false;
  users.users.defuser = {
    isNormalUser = true;
    description = "Oddbjørn Mestad Rønnestad";
    extraGroups = ["networkmanager" "wheel" "lpadmin"];
    hashedPasswordFile = "/etc/passwords/" + defuser;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs.flake-inputs = inputs;
    users.defuser = import ../home;
    backupFileExtension = "hm-backup";
  };
}
