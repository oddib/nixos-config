{
  pkgs,
  ...
}: {
  imports = [
    ./services
    ./apps
    ./system
    ./users
  ];

  # Enable networking
  # Enabling flakes and unfree
  nixpkgs.config.allowUnfree = true;

  services.fwupd.enable = true;
  # Set your time zone.
  time.timeZone = "Europe/Oslo";
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "nb_NO.UTF-8";
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
      AllowUsers = ["oddbjornmr"];
      PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };
}
