{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./tailscale.nix
    ./cache
    ./nix.nix
    inputs.home-manager.nixosModules.home-manager
    ./boot.nix
    ./services
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
      AllowUsers = ["oddbjornmr"]; # Allows all users by default. Can be [ "user1" "user2" ]
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
