{ lib, pkgs, ... }: {
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    gnome.gnome-keyring.enable = true;
  };

  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.login.kwallet.enable = lib.mkForce false;
  security.pam.services.kde.kwallet.enable = lib.mkForce false;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.breeze-gtk
    kdePackages.discover
    kdePackages.kwallet
    kdePackages.partitionmanager
    kdePackages.filelight
    xwaylandvideobridge
    fuzzel
    dracula-theme
    vorta
  ];

}
