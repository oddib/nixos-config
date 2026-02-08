{...}: {
  flake.modules.nixos.gobel = {...}: {
    hardware.facter.reportPath = ./facter.json;
  };
}
