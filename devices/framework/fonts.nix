{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    corefonts # microsoft true type
  ];
}
