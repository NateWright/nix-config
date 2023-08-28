{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages = with pkgs; [
    waybar
    pamixer
    brightnessctl
    (python311.withPackages(ps: with ps; [ requests ]))

    mako
    libnotify
    swww
    kitty
    #rofi-wayland
    wofi
    networkmanagerapplet
  ];
}
