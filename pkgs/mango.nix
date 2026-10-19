{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    waybar
  ];
  wayland.windowManager.mango = {
    enable = true;
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "DISPLAY,:2"
      ];
      # Window effects
      blur = 1;
      blur_optimized = 1;
      blur_params = {
        radius = 5;
        num_passes = 2;
      };
      border_radius = 6;
      focused_opacity = 1.0;

      # Animations - use underscores for multi-part keys
      animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_duration_open = 400;
      animation_duration_close = 800;

      mouse = {
        accel_profile = 1;
        accel_speed = -0.1;
      };
      xkb_rules = {
        layout = "us,es";
        options = "grp:win_space_toggle";
      };
      sloppy_focus = 0;
      cursor_hide_on_keypress = 1;

      # Or use nested attrs (will be flattened with underscores)
      animation_curve = {
        open = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
      };
      # monitorrule = [
      #   "name:^DP-1$,width:2560,height:1440,refresh:179.999,x:1080,y:0,scale:1.1,vrr:0,rr:0"
      #   "name:^DP-3$,width:2560,height:1080,refresh:99.943,x:0,y:-500,scale:1,vrr:0,rr:1"
      #   "name:^HDMI-A-1$,width:1920,height:1080,refresh:60,x:3408,y:0,scale:1,vrr:0,rr:3"
      # ];
      # Use lists for duplicate keys like bind and tag_rule
      # circle_layout = "";
      bind = [
        # Layouts
        "SUPER,x,switch_layout"
        "SUPER,4,setlayout, scroller "
        "SUPER,5,setlayout, monocle "
        # Monitores
        "SUPER+ALT,h,focusmon,left"
        "SUPER+ALT,l,focusmon,right"
        "SUPER+ALT,Left,focusmon,left"
        "SUPER+ALT,Right,focusmon,right"
        "SUPER+CTRL,h,tagmon,left"
        "SUPER+CTRL,l,tagmon,right"
        "SUPER+CTRL,Left,tagmon,left"
        "SUPER+CTRL,Right,tagmon,right"
        # Ventanas
        "SUPER,q,killclient,"
        "SUPER,h,focusdir,left"
        "SUPER,l,focusdir,right"
        "SUPER,j,focusdir,down"
        "SUPER,k,focusdir,up"
        "SUPER,Left,focusdir,left"
        "SUPER,Right,focusdir,right"
        "SUPER,Up,focusdir,up"
        "SUPER,Down,focusdir,down"
        "SUPER+SHIFT,h,exchange_client,left"
        "SUPER+SHIFT,l,exchange_client,right"
        "SUPER+SHIFT,j,exchange_client,down"
        "SUPER+SHIFT,k,exchange_client,up"
        "SUPER,f,togglemaximizescreen,"
        "SUPER+ALT,f,togglefullscreen,"
        "SUPER+ALT,v,togglefloating,"
        "SUPER,Tab,toggleoverview,"
        "SUPER,r,switch_proportion_preset,"
        "SUPER,c,centerwin,"

        # Lanzadores
        "SUPER,t,spawn,kitty"
        "SUPER+SHIFT,t,spawn,warp-terminal"
        "SUPER+SHIFT,Tab,spawn,alacritty"
        "SUPER,p,spawn,rofi -show drun"
        "SUPER,semicolon,spawn,rofi -show window"
        "SUPER+SHIFT,d,spawn,fuzzel"
        "SUPER,d,spawn,kitty -e yazi"
        # Pinyin / fcitx
        "SUPER,0,spawn_shell,wl-paste | pinyin | wl-copy && wtype -M ctrl -k v -m ctrl"
        "SUPER,6,spawn_shell,fcitx5 -r"
        "SUPER,8,spawn_shell,wtype -M ctrl -k c -m ctrl && wl-paste | pinyin | wl-copy && wtype -M ctrl -k v -m ctrl"
        "SUPER,y,spawn_shell,wtype -M ctrl -k c -m ctrl && wl-paste | pinyin | wl-copy"
        "SUPER,apostrophe,spawn_shell,wl-paste | pinyin | wl-copy"
        # Capturas
        "NONE,Print,spawn_shell,CHUNK=$(slurp) && FILE=~/Pictures/ScreenShots/$(date +%Y%m%d_%H%M%S).png && grim -g \"$CHUNK\" \"$FILE\" && wl-copy < \"$FILE\" && notify-send 'screenshot copied!'"
        "SUPER,Print,spawn_shell,FILE=~/Pictures/ScreenShots/$(date +%Y%m%d_%H%M%S)_fd.png && grim - | tee \"$FILE\" | wl-copy && notify-send 'screenshot copied'"

        # Multimedia
        "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01+"
        "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.01-"
        "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "NONE,XF86AudioMicMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        "NONE,XF86AudioPlay,spawn,playerctl play-pause"
        "NONE,XF86AudioNext,spawn,playerctl next"
        "NONE,XF86AudioPrev,spawn,playerctl previous"
        "NONE,XF86AudioStop,spawn,playerctl stop"
        # ───────── Salir ─────────
        "CTRL+ALT,Delete,quit"
        "SUPER+SHIFT,e,quit"
      ];

      tag_rule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:scroller"
      ];

      # Keymodes (submaps) for modal keybindings
      key_mode = {
        resize = {
          bind = [
            "SUPER,Left,resizewin,-10,0"
            "NONE,Escape,setkeymode,default"
          ];
        };
      };
      monitor_rule = [
        "name:^DP-3$,width:2560,height:1080,refresh:99.943,x:0,y:0,scale:1,rr:1"
        "name:^DP-1$,width:2560,height:1440,refresh:179.999,x:1080,y:500,scale:1.1,rr:0"
        "name:^HDMI-A-1$,width:1920,height:1080,refresh:60,x:3408,y:500,scale:1,rr:3"
      ];
      exec_once = ["waybar" "xwayland-satellite :2"];
    };
  };
}
