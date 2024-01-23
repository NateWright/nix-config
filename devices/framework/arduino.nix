{ config, pkgs, ... }:
{
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="0043", MODE="666", SYMLINK+="stretch/handle", GROUP="dialout"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="239a", GROUP="plugdev", MODE="0666"
    SUBSYSTEM == "tty", KERNEL=="ttyACM[0-9]*", MODE="0660"
    SUBSYSTEM == "usb", ATTRS{idVendor}=="03e7", MODE="0666"
  '';
}
