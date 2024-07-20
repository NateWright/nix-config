{ config, pkgs, ... }:
{
  fonts.packages = with pkgs; [
    corefonts # microsoft true type
  ];
}
