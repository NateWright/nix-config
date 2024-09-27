{ ... }: {
  services.borgbackup.repos = {
    nwright-nixos-pc = {
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCrXwrARo7f04l6ZASsuaUCEJLRmENkSnETQizQiV5F"
      ];
      path = "/vault/backups/backup_nwright_nwright-nixos-pc";
    };
  };
}
