{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    displayManager.sddm.enable = true;

    desktopManager.plasma6.enable = true;

  };

}
