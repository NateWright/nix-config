{ pkgs, ... }:
{
  services.sanoid = {
    enable = true;
    templates = {
      "template_production" = {
        yearly = 0;
        monthly = 3;
        daily = 30;
        hourly = 36;
        autosnap = false;
        autoprune = true;
      };
    };
    datasets = {
      "backup/rpool" = {
        useTemplate = [
          "template_production"
        ];
        recursive = true;
        processChildrenOnly = true;
      };
      "backup/vault" = {
        useTemplate = [
          "template_production"
        ];
        recursive = true;
        processChildrenOnly = true;
      };
    };
  };
  services.syncoid = {
    enable = true;
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
