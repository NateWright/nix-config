# Nate's Nix Configs
This git repo contains all of my computers from my house to the cloud. All declaritive which gives me piece of mind.

### Useful commands
```bash
# Used for rev in fetchFromGithub
git rev-parse HEAD
```


### Notes:
zfs creation commands
```bash
zpool create vault mirror -m /mnt/vault -o ashift=12 -O compression=zstd /dev/disk/by-id/ata-WDC_WD120EFGX-68CPHN0_WD-B00SJMSD /dev/disk/by-id/ata-WDC_WD120EFGX-68CPHN0_WD-B00SY9SD
zfs create vault/containers
zfs create vault/containers
zfs create vault/backups
```
