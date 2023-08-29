{ config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    pamixer
    brightnessctl
    (python311.withPackages (ps: with ps; [ requests ]))

    mako
    libnotify
    swww
    kitty
    #rofi-wayland
    wofi
    networkmanagerapplet
    gnome.nautilus
  ];
  # Swaylock fix
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

}
