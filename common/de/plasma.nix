{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    displayManager.sddm.enable = true;
    # displayManager.sddm.theme = "tokyo-night-sddm";

    desktopManager.plasma6.enable = true;

  };

}
