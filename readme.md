# Nixos config

Some annoying commands to type when reinstalling systems

#### Secure boot:
- Run

```bash
cd /tmp
root=$(mktemp -d)
sudo nix run nixpkgs#sbctl create-keys -e ${root}/var/lib/sbctl
mkpasswd PASSWORD > ${root}/etc/passwords/oddbjornmr

```


```bash
nix run github:nix-community/nixos-anywhere -- \
--flake .#gobel \
--target-host user@host

```
### Post install
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
