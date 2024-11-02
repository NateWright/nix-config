{ pkgs, ... }:
{
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.systemPackages = with pkgs; [ seahorse ];
  environment.sessionVariables.COSMIC_DISABLE_DIRECT_SCANOUT = "1";
}
