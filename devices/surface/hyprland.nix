{ config, pkgs, inputs, ... }:
{
  programs.hyprland.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nwright.enableGnomeKeyring = true;
  # For nautilus smb share
  services.gvfs.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    pamixer
    brightnessctl
    (python311.withPackages (ps: with ps; [ requests ]))

    mako
    libnotify
    swww
    kitty
    rofi-wayland
    wofi
    networkmanagerapplet
    gnome.nautilus
    gnome.gnome-software
    blueberry
    pavucontrol
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    wlogout
    swaylock-effects
  ];
  # Swaylock fix
  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';

}
