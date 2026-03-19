{ pkgs, ... }:
{
  services.sanoid = {
    enable = true;
    templates = {
      "template_backup" = {
        yearly = 0;
        monthly = 12;
        daily = 30;
        hourly = 24;
        autosnap = false;
        autoprune = true;
      };
    };
    datasets = {
      "backup/server-nixos-1_rpool" = {
        useTemplate = [
          "template_backup"
        ];
        recursive = true;
        processChildrenOnly = true;
      };
      "backup/server-nixos-1_vault" = {
        useTemplate = [
          "template_backup"
        ];
        recursive = true;
        processChildrenOnly = true;
      };
    };
  };
  services.syncoid = {
    enable = true;
    interval = "*-*-* 01:00:00";
    commonArgs = [
      "--no-privilege-elevation"
    ];
    localTargetAllow = [
      "compression"
      "mountpoint"
      "create"
      "mount"
      "receive"
      "rollback"
      "destroy"
    ];
    commands = {
      "server-nixos-1_rpool" = {
        sshKey = "/var/lib/syncoid/backup.key";
        recursive = true;
        source = "zfs-syncoid@server-nixos-1:rpool";
        target = "backup/server-nixos-1_rpool";
        extraArgs = [
          "--exclude-datasets=root"
          "--exclude-datasets=nix"
        ];
      };
      "server-nixos-1_vault" = {
        sshKey = "/var/lib/syncoid/backup.key";
        recursive = true;
        source = "zfs-syncoid@server-nixos-1:vault";
        target = "backup/server-nixos-1_vault";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    sanoid
  ];
}
