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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
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
