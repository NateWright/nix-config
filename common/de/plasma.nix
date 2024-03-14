{ config, lib, pkgs, ... }:
{
  services.xserver = {
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    # displayManager.sddm.theme = "tokyo-night-sddm";

  };
  
  services.desktopManager.plasma6.enable = true;

  programs.dconf.enable = true;
  # services.packagekit.enable = true;

  environment.systemPackages = with pkgs; [
    kdePackages.discover
    xwaylandvideobridge
  ];

}
