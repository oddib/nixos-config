On init
set new one time tailscale auth 

sudo nix run --extra-experimental-features nix-command --extra-experimental-features flakes 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake 'github:oddib/nixos-config/main'#gobel