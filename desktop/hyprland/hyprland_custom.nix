
{ inputs, pkgs, ... }:
{
  imports =[
    ./rofi.nix
    ./waybar.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    # Usar systemd para iniciar Hyprland
    systemd.enable = true;

    # TODA tu configuración va en "settings"
    settings = {

      # ───────────────────────────────────
      # VARIABLES DE ENTORNO
      # ───────────────────────────────────
      # Variables de entorno para modo oscuro
      env = [
        "GTK_THEME,Adwaita:dark"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_STYLE_OVERRIDE,Adwaita-Dark"
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        # NVIDIA
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "WLR_NO_HARDWARE_CURSORS,1"
        # XDG
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_CACHE_HOME,$HOME/.cache"
        "XDG_CONFIG_HOME,$HOME/.config"
        "XDG_DATA_HOME,$HOME/.local/share"
      ];
      # ───────────────────────────────────
      # MONITORES
      # ───────────────────────────────────
      monitor = [
        # Monitor principal: DP-3 (Ultrawide)
        "DP-3,2560x1080@99.943,0x0,1"

        # Monitor secundario: HDMI-A-1 (Vertical)
        "HDMI-A-1,1920x1080@74.943,-1080x-400,1,transform,3"

        # Fallback
        # ",preferred,auto,1"
      ];

      # ───────────────────────────────────
      # WORKSPACES POR MONITOR
      # ───────────────────────────────────
      workspace = [
        "1,monitor:DP-3,default:true"
        "2,monitor:DP-3"
        "3,monitor:DP-3"
        "4,monitor:DP-3"
        "5,monitor:DP-3"
        "6,monitor:HDMI-A-1"
        "7,monitor:HDMI-A-1"
        "8,monitor:HDMI-A-1"
      ];

      # ───────────────────────────────────
      # INPUT
      # ───────────────────────────────────
      input = {
        kb_layout = "us,es";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      # ───────────────────────────────────
      # GENERAL
      # ───────────────────────────────────
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      # ───────────────────────────────────
      # DECORATION
      # ───────────────────────────────────
      # decoration = {
      #   rounding = 10;

      #   blur = {
      #     enabled = true;
      #     size = 3;
      #     passes = 1;
      #   };

      #   drop_shadow = true;
      #   shadow_range = 4;
      #   shadow_render_power = 3;
      #   "col.shadow" = "rgba(1a1a1aee)";
      # };

      # ───────────────────────────────────
      # ANIMATIONS
      # ───────────────────────────────────
      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # ───────────────────────────────────
      # LAYOUTS
      # ───────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # ───────────────────────────────────
      # MISC
      # ───────────────────────────────────
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        vrr = 0;
      };

      # ───────────────────────────────────
      # CURSOR (NVIDIA)
      # ───────────────────────────────────
      cursor = {
        no_hardware_cursors = true;
      };

      # ───────────────────────────────────
      # KEYBINDS
      # ───────────────────────────────────
      "$mod" = "SUPER";

      bind = [
        # Rofi launchers
        # "$mod, D, exec, rofi -show drun"
        # "$mod SHIFT, R, exec, rofi -show drun"
        "$mod SHIFT, E, exec, rofi -show filebrowser"
        "$mod SHIFT, S, exec, rofi -show ssh"

        # Aplicaciones
        "$mod, Return, exec, alacritty"
        "$mod, Q, killactive"
        "$mod, M, exit"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"
        "$mod, D, exec, rofi -show drun"
        # "$mod, R, exec, wofi --show drun"
        "$mod, B, exec, brave"

        # Focus
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Multi-monitor
        "$mod, period, focusmonitor, +1"
        "$mod, comma, focusmonitor, -1"
        "$mod SHIFT, period, movewindow, mon:+1"
        "$mod SHIFT, comma, movewindow, mon:-1"

        # Screenshots
        ", Print, exec, grim -g $(slurp) - | wl-copy"
      ]
      # WORKSPACES - Usando el método del ejemplo
      ++ (
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            # Cambiar a workspace
            "$mod, ${toString ws}, workspace, ${toString ws}"
            # Mover ventana a workspace
            "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
          ]
        ) 8)  # 8 workspaces (1-8)
      );

      # ───────────────────────────────────
      # MOUSE BINDS
      # ───────────────────────────────────
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # ───────────────────────────────────
      # WINDOW RULES
      # ───────────────────────────────────
      # windowrulev2 = [
      #   # Transparencia para terminales
      #   "opacity 0.95 0.95,class:^(kitty)$"
      #   "opacity 0.95 0.95,class:^(Alacritty)$"

      #   # Apps específicas en monitor vertical
      #   "workspace 6,class:^(discord)$"
      #   "workspace 6,class:^(WebCord)$"
      #   "workspace 7,class:^(Spotify)$"
      # ];

      # ───────────────────────────────────
      # AUTOSTART
      # ───────────────────────────────────
      exec-once = [
        "mako"
        "hyprpaper"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # "swww init"
        # "nm-applet"
      ];
    };
  };

  # ═══════════════════════════════════════
  # PROGRAMAS ADICIONALES
  # ═══════════════════════════════════════


  # Alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.80;
        padding = {
          x = 10;
          y = 10;
        };
      };
      font.size = 11;
    };
  };

  services.mako = {
    enable = true;
    settings = {
    default-timeout = 5000;
    text-color = "#cdd6f4";
    background-color = "#1e1e2e";
    };
  };



}
