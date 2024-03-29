{ config, pkgs, inputs, ... }:
{
  programs.hyprland.enable = true;
  # programs.hyprland.package = pkgs.unstable.hyprland;
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.wlr.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.nwright.enableGnomeKeyring = true;
  # For nautilus smb share
  services.gvfs.enable = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    unstable.waybar
    pamixer
    brightnessctl
    (python311.withPackages (ps: with ps; [ requests ]))

    wl-clipboard
    cliphist
    mako
    libnotify
    swww
    kitty
    alacritty
    rofi-wayland
    wofi
    networkmanagerapplet
    gnome.nautilus
    gnome.file-roller
    gnome.gnome-software
    blueberry # Bluetooth gui
    system-config-printer # Printer gui
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
