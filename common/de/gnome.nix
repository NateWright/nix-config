{ config, lib, pkgs, ... }:
{
  services.xserver = {
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

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome-extension-manager
    gnome.nautilus-python
    gnome.sushi
    nautilus-open-any-terminal
  ];

}
