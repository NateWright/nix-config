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

    gtk2.extraConfig = ''
      gtk-enable-animations=1
      gtk-primary-button-warps-slider=1
      gtk-toolbar-style=3
      gtk-menu-images=1
      gtk-button-images=1
      gtk-cursor-theme-size=24
      gtk-sound-theme-name="ocean"
      gtk-icon-theme-name="breeze-dark"
      gtk-font-name="Noto Sans,  10"
    '';

    gtk3.extraConfig = {
      gtk-cursor-theme-size = 24;
      gtk-application-prefer-dark-theme = 0;
    };

    gtk4.extraConfig = {
      gtk-cursor-theme-size = 24;
      gtk-application-prefer-dark-theme = 0;
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
