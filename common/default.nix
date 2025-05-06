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
  i18n.defaultLocale = "nb_NO.UTF-8";
  # Configure console keymap
  console.keyMap = "no";
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
    #initialHashedPassword = "$y$j9T$SAQb63c3fPa6VfJ2K/4FV/$pRTZFnC4BOUFr9.raMosv1nsKwXepy9tQEzNvY.Ia2B";
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs.flake-inputs = inputs;
    users.oddbjornmr = import ../home;
    backupFileExtension = "hm-backup";
  };
}
