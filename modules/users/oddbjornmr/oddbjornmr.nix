{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    (self.factory.user "oddbjornmr" true)
    {
      nixos.oddbjornmr = {
        imports = with self.modules.nixos; [
          onepass
          # developmentEnvironment
        ];
        users.users.oddbjornmr = {
          extraGroups = ["networkmanager" "lpadmin"];
        };
      };

      # darwin.oddbjornmr = {
      #   imports = with self.modules.darwin; [
      #     # drawingApps
      #     # developmentEnvironment
      #   ];
      # };

      homeManager.oddbjornmr = {pkgs, ...}: {
        imports = with self.modules.homeManager; [
          system-desktop
          # adminTools
          vscode
        ];
        programs = {
          git = {
            settings = {
              user = {
                name = "Oddbjørn Rønnestad";
                email = "60390653+oddib@users.noreply.github.com";
              };
              gpg.format = "ssh";
              "gpg \"ssh\"".program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
              commit.gpgsign = true;
              user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDCJ0s4kA8stxlBhrxhyN1bQyBh8LFE+HsoNZbas83V";
            };
          };
          ssh = {
            matchBlocks = {
              "*" = {
                identityAgent = "~/.1password/agent.sock";
              };
            };
          };
        };
      };
    }
  ];
}
