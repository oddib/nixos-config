{
  inputs,
  pkgs,
  ...
}: {
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
      /* extraLocales = [
      "nn_NO.UTF-8"
      "en_US.UTF-8"
      "en_GB.UTF-8"]; */
  };
  ## Configure console keymap
  console.keyMap = "no";
  environment.systemPackages = with pkgs; [
    #  vim 
    #  wget
    duplicacy
  ];
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowUsers = ["oddbjornmr"];
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
  users.mutableUsers = false;
  users.users.oddbjornmr = {
    isNormalUser = true;
    description = "Oddbjørn Mestad Rønnestad";
    extraGroups = ["networkmanager" "wheel"];
    hashedPasswordFile = "/etc/passwords/oddbjornmr";
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs.flake-inputs = inputs;
    users.oddbjornmr = import ../home;
    backupFileExtension = "hm-backup";
  };
}
