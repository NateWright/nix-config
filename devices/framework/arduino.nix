{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM == "tty", GROUP="plugdev". MODE="0660"
    SUBSYSTEMS=="usb", ATTRS{idProduct}=="0043", ATTRS{idVendor}=="2a03", SYMLINK+="stretch-handle"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", GROUP="plugdev", MODE="0666"
  '';
}
