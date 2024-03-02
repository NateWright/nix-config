{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb =
      {
        layout = "us";
        variant = "";
      };
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;

  };

}
