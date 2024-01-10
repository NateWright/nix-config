### Install Example
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#device
home-manager switch --flake .#nwright@device
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

### nwright-framework
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#nwright-framework
```

### nwright-nixos-pc
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#nwright-nixos-pc
home-manager switch --flake .#nwright@nwright-nixos-pc
```

### server
```bash
cd ~/nix-config
sudo nixos-rebuild switch --flake .#server
```
#### get hugo revision
```bash
git rev-parse HEAD
```