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
    git stash
    git fetch
    git pull
    git switch -c update-just
    nix flake update --commit-lock-file
    nixos-rebuild --flake . build
    git switch -
    git merge update-just --squash
    git branch -D update-just
commit:
    git add --all
    nix flake check
    git commit