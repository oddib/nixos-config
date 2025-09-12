{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
in {
  programs = {
    bash = {
      enable = mkDefault true;
      enableCompletion = true;
      # TODO add your custom bashrc here
      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      '';
    };
    starship = {
      enable = mkDefault true;
    };

    git = {
      enable = mkDefault true;
      userName = "Oddbjørn Rønnestad";
      userEmail = "60390653+oddib@users.noreply.github.com";
      extraConfig = {
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
        commit.gpgsign = true;
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDCJ0s4kA8stxlBhrxhyN1bQyBh8LFE+HsoNZbas83V";
      };
    };
    ssh = {
      enable = mkDefault true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          identityAgent = "~/.1password/agent.sock";
        };
        "scuffedflix" = {
          user = "oddbjornmr";
          forwardAgent = true;
        };
      };
    };
  };
  home.packages = with pkgs; [
    fastfetch

    # archives
    zip
    xz
    unzip
    p7zip

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    nixd # language server
    alejandra # formatter

    # productivity
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];
}
