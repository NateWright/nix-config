{
  pkgs,
  ...
}:
{
  gtk = {
    enable = true;
    cursorTheme.name = "Catppuccin-Macchiato-Mauve-Cursors";
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
    };
  };
  home.sessionVariables.GTK_THEME = "adw-gtk3-dark";
}
