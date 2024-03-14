# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/83b007f0-5e1a-4e5d-a5fe-efa3ca97ca65";
      fsType = "btrfs";
      options = [ "subvol=@root" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/83b007f0-5e1a-4e5d-a5fe-efa3ca97ca65";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/83b007f0-5e1a-4e5d-a5fe-efa3ca97ca65";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/BB7B-7FF2";
      fsType = "vfat";
    };

  fileSystems."/vault/containers" =
    {
      device = "/dev/disk/by-label/vault";
      fsType = "btrfs";
      options = [ "subvol=@containers" ];
    };
  fileSystems."/vault/datastorage" =
    {
      device = "/dev/disk/by-label/vault";
      fsType = "btrfs";
      options = [ "subvol=@datastorage" ];
    };
  fileSystems."/vault-old" =
    {
      device = "/dev/disk/by-label/vault";
      fsType = "btrfs";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # high-resolution display
}
