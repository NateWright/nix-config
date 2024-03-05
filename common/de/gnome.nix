{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb =
      {
        layout = "us";
        variant = "";
      };

    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    desktopManager = {
      gnome.enable = true;
    };
  };

}
