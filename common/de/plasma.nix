{ lib, pkgs, ... }:
{
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.login.kwallet.enable = lib.mkForce false;
  security.pam.services.kde.kwallet.enable = lib.mkForce false;
  programs.dconf.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages = with pkgs; [
    kdePackages.breeze-gtk
    kdePackages.discover
    kdePackages.kwallet
    kdePackages.partitionmanager
    kdePackages.filelight
    fuzzel
    dracula-theme
    vorta
    tailscale-systray
  ];

}
