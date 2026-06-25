{...}: {
  programs.noctalia = {
    enable = true;

    settings = {
      # This may also be a string or path to a .toml file.
      location = {
        address = "Ipis San Jose Costa Rica";
        auto_locate = false;
      };

      bar = {
        order = ["widgets"];
        widgets = {
          auto_hide = false;
          background_opacity = 0.75;
          border = "outline";
          margin_edge = 3;
          margin_ends = 10;
          padding = 12;
          scale = 0.95;
          color = "secondary";
          icon_color = "tertiary";
          shadow = true;
          enable = true;
          center = ["clock" "date"];
          end = ["cat_2" "workspaces" "volume" "tray" "keyboard_layout" "notifications"];
          start = ["control-center" "cpu" "ram" "network_tx" "network_rx" "media"];
          thickness = 25;
          widget_spacing = 16;
        };
      };

      control_center = {
        sidebar_section = "compact";
        sidebar = "compact";
      };

      lockscreen = {
        enabled = false;
      };

      osd = {
        position = "top_left";
      };

      plugins = {
        enable = ["noctalia/bongocat"];
      };
      shell = {
        screen_time_enabled = true;
        settings_show_advanced = true;
        avatar_path = "/home/joronix/mi_niri_flake/pkgs/desktop/icons/amagai_kikuno_1.png";
        font_family = "JetBrainsMono NF SemiBold";

        panel = {
          clipboard_placement = "floating";
          clipboard_position = "bottom_left";
          open_near_click_clipboard = true;
          launcher_placement = "attached";
          transparency_mode = "glass";
        };
      };
      theme = {
        builtin = "Nord";
        community_palette = "Everforest";
        community_pallete = "Everforest";
        custom_pallete = "";
        mode = "dark";
        source = "community";
        wallpaper_sheme = "m3-content";
        templates = {
          enable_builtin_templates = true;
          enable_community_templates = true;
        };
      };
      wallpaper = {
        enabled = false;
      };
      widget = {
        cat = {
          type = "noctalia/bongocat:cat";
        };
      };
    };
  };
}
