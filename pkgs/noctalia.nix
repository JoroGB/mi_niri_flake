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
          shadow = true;
          enable = true;
          center = ["clock"];
          end = ["cat_2" "workspaces" "volume" "tray" "keyboard_layout" "notifications"];
          start = ["control-center" "media" "sysmon"];
          thickness = 25;
          widget_spacing = 16;
        };
      };

      control_center = {
        sidebar_section = "full";
      };

      osd = {
        position = "bottom_left";
      };

      plugins = {
        enable = ["noctalia/bongocat"];
      };
      shell = {
        screen_time_enabled = true;
        settings_show_advanced = true;
        panel = {
          clipboard_placement = "floating";
          open_near_click_clipboard = true;
        };
      };
      theme = {
        builtin = "Nord";
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
