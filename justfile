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
    git checkout main
    git switch -c update-just
    nix flake update 
    nix flake check
    git checkout main
    git merge update --squash
    git branch -D update-just
commit:
    git add --all
    nix flake check
    git commit