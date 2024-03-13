{ config, lib, pkgs, ... }:
{
  services.xserver = {
    desktopManager.cosmic.enable = true;
    # displayManager.cosmic-greeter.enable = true;
  };

}
