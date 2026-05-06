# https://just.systems
check:
    nix flake check
switch:
    nh os switch .
test:
    nh os test .
boot:
    nh os boot .
build:
    nh os build .
update:
    git stash
    git fetch
    git pull
    git switch -c update-just
    nix flake update --commit-lock-file
    nh os build .
upgrade:
    git switch main
    git merge update-just --squash --commit
    git branch -D update-just
    git push
commit: 
    git fetch
    git add --all
    nix flake check
    git commit