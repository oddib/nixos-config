# Nixos config

Some annoying commands to type when reinstalling systems
### Format disks
* Gobel (laptop):
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount raw.githubusercontent.com/oddib/nixos-config/refs/heads/main/hosts/gobel/disk-config.nix
```
* Edwin (Gaming desktop)
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount raw. githubusercontent.com/oddib/nixos-config/refs/heads/main/hosts/edwin/disk-config.nix
```
### Install nixos
* Gobel
```bash
nixos-install --flake github:oddib/nixos-config#gobel
```
* Edwin
```bash
nixos-install --flake github:oddib/nixos-config#edwin
```
### Post install
#### Secure boot:
- Run at /etc/secureboot :
```bash
sudo nix run nixpkgs#sbctl create-keys
```
- Reboot
- To verify signing run:
```bash
sudo nix run unstable#sbctl verify
```
- Enroll keys:
```bash
sudo nix run nixpkgs#sbctl enroll-keys -- --microsoft
```
Reboot and verify
```bash
bootctl status
```
If all is good enroll luks keys
```bash 
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=0+2+7+12 --wipe-slot=tpm2 /dev/nvme0n1p2
```