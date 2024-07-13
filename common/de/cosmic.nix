{ config, lib, pkgs, ... }: {
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    gnome.gnome-keyring.enable = true;
  };
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

}
