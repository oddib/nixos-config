{
  inputs,
  ...
}:
{
  flake.modules.nixos.edwin = {
    imports = with inputs.self.modules.nixos; [
      oddbjornmr
    ];

    home-manager.users.oddbjornmr = {
      ###
    };
  };
}