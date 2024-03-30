{ config, lib, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb =
      {
        layout = "us";
        variant = "";
      };
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

}
