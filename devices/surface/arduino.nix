{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", GROUP="plugdev", MODE="0666", SYMLINK+="stretch-handle"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", GROUP="plugdev", MODE="0666"
  '';
}
