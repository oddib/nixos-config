# Nixos config

Some annoying commands to type when reinstalling systems

## Creating Iso file and imaging
Generate Iso:
```bash
nix build .#nixosConfigurations.iso.config.system.build.isoImage
```

```bash
sudo dd if=result/iso/*.iso of=/dev/sdX status=progress
```
/dev/sdX is the install media
## Get ready for install:

#### Run:
```bash
cd /tmp

root=$(mktemp -d)

mkpasswd PASSWORD > ${root}/etc/passwords/oddbjornmr
```
#### only needed for secure boot
```bash
sudo nix run nixpkgs#sbctl create-keys -e ${root}/var/lib/sbctl
```
#### Run nixos anywhere:
```bash
nix run github:nix-community/nixos-anywhere -- \
--flake .#gobel \
--target-host user@host

```
## Post install
### Secure boot: 
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
