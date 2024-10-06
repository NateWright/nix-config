{ pkgs, lib, ... }:
{
  imports = [
    ./avizo # on-screen display for audio and backlight
    ./fuzzel # app launcher, emoji picker and clipboard manager
    ./grimblast # screenshot grabber and annotator
    ./hyprlock # screen locker
    ./hyprpaper # wallpaper setter
    ./swaync # notification center
    ./waybar # status bar
    ./wlogout # session menu
  ];
  services = {
    gpg-agent.pinentryPackage = lib.mkForce pkgs.pinentry-gnome3;
    udiskie = {
      enable = true;
      automount = false;
      tray = "auto";
      notify = true;
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "hyprland-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
    plugins = with pkgs; [ hyprlandPlugins.hyprtrails ];
    settings = {
      monitor = "eDP-1,highres,auto,1";
      "$mod" = "SUPER";
      # Work when input inhibitor (l) is active.
      bindl = [
        ", XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause"
        ", XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous"
        ", XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next"
      ];
      # https://en.wikipedia.org/wiki/Table_of_keyboard_shortcuts
      bind =
        [
          # Process management
          "$mod, Q, killactive"
          # Launch applications
          "$mod, E, exec, nautilus --new-window"
          "$mod, T, exec, alacritty"
          # Move focus
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"
          "ALT SHIFT, Tab, cyclenext, prev"
          "ALT SHIFT, Tab, bringactivetotop"
          # Move focus with SHIFT + arrow keys
          "ALT, left, movefocus, l"
          "ALT, right, movefocus, r"
          "ALT, up, movefocus, u"
          "ALT, down, movefocus, d"
          "ALT $mod, left, swapwindow, l"
          "ALT $mod, right, swapwindow, r"
          "ALT $mod, up, swapwindow, u"
          "ALT $mod, down, swapwindow, d"
          "$mod, up, fullscreen, 1"
          "$mod, down, togglefloating"
          "$mod, P, pseudo"
          # Switch workspace
          "CTRL ALT, left, workspace, e-1"
          "CTRL ALT, right, workspace, e+1"
        ]
        ++ map (n: "$mod SHIFT, ${toString n}, movetoworkspace, ${toString (if n == 0 then 10 else n)}") [
          1
          2
          3
          4
          5
          6
          7
          8
          9
          0
        ]
        ++ map (n: "$mod, ${toString n}, workspace, ${toString (if n == 0 then 10 else n)}") [
          1
          2
          3
          4
          5
          6
          7
          8
          9
          0
        ];
      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;
        first_launch_animation = false;
      };
      # https://wiki.hyprland.org/Configuring/Animations/
      animation = [
        "windows, 1, 6, wind, slide"
        "windowsIn, 1, 6, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 10, liner"
        "borderangle, 1, 100, linear, loop"
        "fade, 1, 10, default"
        "workspaces, 1, 5, wind"
      ];
      bezier = [
        "wind, 0.05, 0.9, 0.1, 1.05"
        "winIn, 0.1, 1.1, 0.1, 1.1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
        "linear, 0.0, 0.0, 1.0, 1.0"
      ];
      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
        dim_inactive = true;
        dim_strength = 2.5e-2;
        # Subtle shadows
        "col.shadow" = "rgba(11111baf)";
        "col.shadow_inactive" = "rgba(1e1e2eaf)";
        drop_shadow = true;
        shadow_range = 304;
        shadow_render_power = 4;
        shadow_offset = "0, 42";
        shadow_scale = 0.9;
        blur = {
          enabled = true;
          passes = 2;
          size = 6;
          ignore_opacity = true;
        };
      };
      exec-once = [
        "hypr-session start"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgb(cba6f7) rgb(f38ba8) rgb(eba0ac) rgb(fab387) rgb(f9e2af) rgb(a6e3a1) rgb(94e2d5) rgb(89dceb) rgb(89b4fa) rgb(b4befe) 270deg";
        "col.inactive_border" = "rgb(45475a) rgb(313244) rgb(45475a) rgb(313244) 270deg";
        resize_on_border = true;
        extend_border_grab_area = 10;
        layout = "master";
      };
      # https://wiki.hyprland.org/Configuring/Master-Layout/
      master = {
        mfact = 0.5;
        orientation = "left";
      };
      # https://wiki.hyprland.org/Configuring/Dwindle-Layout/
      dwindle = {
        force_split = 1;
        preserve_split = true;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = false;
      };
      group = {
        groupbar = {
          font_family = "Work Sans";
          font_size = 12;
          gradients = true;
        };
      };
      input = {
        kb_layout = "us";
        follow_mouse = 2;
        repeat_rate = 30;
        repeat_delay = 300;
        touchpad = {
          clickfinger_behavior = true;
          middle_button_emulation = true;
          natural_scroll = true;
          tap-to-click = true;
        };
      };
      misc = {
        animate_manual_resizes = false;
        background_color = "rgb(30, 30, 46)";
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        vfr = true;
      };
      plugin = {
        hyprtrails = {
          color = "rgba(a6e3a1aa)";
          bezier_step = 2.5e-2; # 0.025
          points_per_step = 2; # 2
          history_points = 12; # 20
          history_step = 2; # 2
        };
      };
      windowrulev2 = [
        # only allow shadows for floating windows
        "noshadow, floating:0"
        # make floating windows opaque
        "opacity 0.72, floating:1"
        # Some windows should never be opaque
        "opacity 1.0, class: com.obsproject.Studio"
        "opacity 1.0, class: resolve"
        "opacity 1.0, class: com.defold.editor.Start"
        "opacity 1.0, class: class: dmengine"
        "opacity 1.0, title: UNIGINE Engine"

        # make pop-up file dialogs floating, centred, and pinned
        "float, title:(Open|Progress|Save File)"
        "center, title:(Open|Progress|Save File)"
        "pin, title:(Open|Progress|Save File)"
        "float, class:(xdg-desktop-portal-gtk)"
        "center, class:(xdg-desktop-portal-gtk)"
        "pin, class:(xdg-desktop-portal-gtk)"
        "float, class:^(code)$"
        "center, class:^(code)$"
        "pin, class:^(code)$"

        # Apps that should be floating
        "float, title:(Maestral Settings|MainPicker|overskride|Pipewire Volume Control|Trayscale)"
        "center, title:(Maestral Settings|MainPicker|overskride|Pipewire Volume Control|Trayscale)"
        "float, initialTitle:(Polychromatic|Syncthing Tray)"
        "center, initialTitle:(Polychromatic|Syncthing Tray)"
        "float, class:(.blueman-manager-wrapped|blueberry.py|nm-connection-editor|org.gnome.Calculator|polkit-gnome-authentication-agent-1)"
        "center, class:(.blueman-manager-wrapped|blueberry.py|nm-connection-editor|org.gnome.Calculator|polkit-gnome-authentication-agent-1)"
        "size 700 580, title:(.blueman-manager-wrapped)"
        "size 580 640, title:(blueberry.py)"
        "size 600 402, title:(Maestral Settings)"
        "size 512 290, title:(MainPicker)"
        "size 395 496, class:(org.gnome.Calculator)"
        "size 700 500, class:(nm-connection-editor)"
        "size 1134 880, title:(Pipewire Volume Control)"
        "size 960 640 initialTitle:(Polychromatic)"
        "size 880 1010, title:(overskride)"
        "size 886 960, title:(Trayscale)"
      ];
      layerrule = [
        "blur, launcher" # fuzzel
        "ignorezero, launcher"
        "blur, logout_dialog" # wlogout
        "blur, rofi"
        "blur, swaync-control-center"
        "blur, swaync-notification-window"
        "ignorealpha 0.7, swaync-control-center"
        "ignorealpha 0.7, swaync-notification-window"
      ];
      xwayland = {
        force_zero_scaling = true;
      };
    };
    systemd = {
      enableXdgAutostart = true;
      variables = [ "--all" ];
    };
    xwayland.enable = true;
  };
  # https://github.com/hyprwm/hyprland-wiki/issues/409
  # https://github.com/nix-community/home-manager/pull/4707
  xdg.portal = {
    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
    };
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };
}
