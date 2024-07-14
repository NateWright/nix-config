{ pkgs, ... }: {
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
  };
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

  environment.systemPackages = with pkgs; [ seahorse ];
}
