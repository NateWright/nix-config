{ config, pkgs, inputs, outputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      monitor = ",highres,auto,auto";

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0;
      };

      "$mod" = "SUPER";
      bind = [

      ];
    };
  };
}
