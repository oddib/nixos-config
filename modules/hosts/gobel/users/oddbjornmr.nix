{
  inputs,
  ...
}:
{
  flake.modules.nixos.gobel = {
    imports = with inputs.self.modules.nixos; [
      oddbjornmr
    ];

    home-manager.users.oddbjornmr = {
      ###
    };
  };
}