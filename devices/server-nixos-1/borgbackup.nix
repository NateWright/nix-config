{ ... }:
{
  services.borgbackup.repos = {
    nwright-nixos-pc = {
      authorizedKeys = [
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMCrXwrARo7f04l6ZASsuaUCEJLRmENkSnETQizQiV5F"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINk9Wr+xV4oT3cY56ImHqr4haZWI/NM3nfE5B64YnLpa nwright@DESKTOP-2QJDFJL"
      ];
      path = "/vault/backups/backup_nwright_nwright-nixos-pc";
    };
  };
}
