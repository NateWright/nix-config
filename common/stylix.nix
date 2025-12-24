{ pkgs, lib, ... }:
let
  theme-pkg = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
in
{
  stylix = {
    enable = true;
    base16Scheme = theme-pkg;
    autoEnable = false;

    targets.console.enable = true;
    targets.kmscon.enable = true;
    targets.qt.enable = true;
  };
  home-manager.sharedModules = [
    (
      { ... }:
      {
        stylix = {
          enable = true;
          autoEnable = false;
          base16Scheme = theme-pkg;
          targets.alacritty.enable = true;
          targets.helix.enable = true;
          targets.lazygit.enable = true;
          targets.zellij.enable = true;
        };

      }
    )
  ];
}
