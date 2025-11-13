# https://just.systems
check:
    nix flake check
switch:
    sudo nixos-rebuild --flake . switch
test:
    sudo nixos-rebuild --flake . test
boot:
    sudo nixos-rebuild --flake . boot
build:
    nixos-rebuild --flake . build
update:
    nix flake update > 
    nix flake check
commit:
    git add --all
    nix flake check
    git commit