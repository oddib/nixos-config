{
  self,
  lib,
  ...
}: {
  flake.modules = lib.mkMerge [
    (self.lib.user "deborah" true)
    {
      nixos.deborah = {
        imports = with self.modules.nixos; [
          onepass
          # developmentEnvironment
        ];
        programs._1password-gui.polkitPolicyOwners = ["deborah"];
        users.users.deborah = {
          extraGroups = ["networkmanager" "lpadmin"];
          description = "Oddbjørn Mestad Rønnestad";
          password = "123";
        };
      };

      # darwin.deborah = {
      #   imports = with self.modules.darwin; [
      #     # drawingApps
      #     # developmentEnvironment
      #   ];
      # };

      homeManager.deborah = {...}: {
        imports = with self.modules.homeManager; [
          system-desktop
          # adminTools
          #vscode
          onepass
          games
          #protonmail
        ];
        # programs.git.settings = {
        #   user = {
        #     name = "Oddbjørn Rønnestad";
        #     email = "60390653+oddib@users.noreply.github.com";
        #   };
        #   user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDCJ0s4kA8stxlBhrxhyN1bQyBh8LFE+HsoNZbas83V";
        # };
      };
    }
  ];
}
