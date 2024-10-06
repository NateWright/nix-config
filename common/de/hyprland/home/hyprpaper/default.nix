{ ... }:
{
  # hyprpaper is a wallpaper manager and part of the hyprland suite
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [
          "/etc/backgrounds/Catppuccin-1920x1080.png"
        ];
        wallpaper = [
          "eDP-1, /etc/backgrounds/Catppuccin-1920x1200.png"
        ];
      };
    };
  };
}
