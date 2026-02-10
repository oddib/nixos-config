{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    (self.lib.user "oddbjornmr" true)
    {
      nixos.oddbjornmr = {
        imports = with self.modules.nixos; [
          onepass
          # developmentEnvironment
        ];
        programs._1password-gui.polkitPolicyOwners = ["oddbjornmr"];
        users.users.oddbjornmr = {
          extraGroups = ["networkmanager" "lpadmin"];
          description = "Oddbjørn Mestad Rønnestad";
          hashedPasswordFile = "/etc/passwords/oddbjornmr";
        };
      };

      # darwin.oddbjornmr = {
      #   imports = with self.modules.darwin; [
      #     # drawingApps
      #     # developmentEnvironment
      #   ];
      # };

      homeManager.oddbjornmr = {...}: {
        imports = with self.modules.homeManager; [
          system-desktop
          # adminTools
          vscode
          onepass
          games
        ];
        programs.git.settings = {
          user = {
            name = "Oddbjørn Rønnestad";
            email = "60390653+oddib@users.noreply.github.com";
          };
          user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDCJ0s4kA8stxlBhrxhyN1bQyBh8LFE+HsoNZbas83V";
        };
      };
    }
  ];
}
