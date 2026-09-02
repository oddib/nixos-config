{inputs, ...}: {
  flake.modules.nixos.edwin = {
    imports = with inputs.self.modules.nixos; [
      deborah
    ];

    home-manager.users.deborah = {
      ###
    };
  };
}
