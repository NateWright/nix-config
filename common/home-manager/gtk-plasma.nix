{
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "Catppuccin-Macchiato-Mauve-Cursors";
    };
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Breeze-Dark";
    };
  };
  home.sessionVariables.GTK_THEME = "Breeze-Dark";
}
