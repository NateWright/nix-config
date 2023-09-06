### Install Example
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#device
home-manager switch --flake '/home/nwright/nix-config/devices/surface#nwright@nwright-surface'
```
### Update Example
```bash
cd ~/nix-config
nix flake update
```
### nwright-surface
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#nwright-surface
home-manager switch --flake .#nwright@nwright-surface
```
### nwright-nixos-pc
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#nwright-nixos-pc
home-manager switch --flake .#nwright@nwright-nixos-pc
```
