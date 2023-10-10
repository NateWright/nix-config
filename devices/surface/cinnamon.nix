{ config, pkgs, inputs, ... }:
{
  services.xserver.desktopManager.cinnamon.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages = [
    pkgs.gnome.gnome-software
  ];
}
