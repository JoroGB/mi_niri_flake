{ config, pkgs, inputs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      modi = "drun,run,window,ssh,filebrowser";
      # show-icons = true;
      location = 0;
      yoffset = 0;
      xoffset = 0;
      fixed-num-lines = true;
      show-icons = true;
      terminal = "alacritty";
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      run-command = "{cmd}";
      run-list-command = "";
      run-shell-command = "{terminal} -e {cmd}";
      window-command = "wmctrl -i -R {window}";
      window-match-fields = "all";
      icon-theme = "Adwaita";
      drun-match-fields = "name,generic,exec,categories,keywords";
      drun-categories = "";
      drun-show-actions = false;
      drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      drun-url-launcher = "xdg-open";
      disable-history = false;
      ignored-prefixes = "";
      sort = false;
      sorting-method = "normal";
      case-sensitive = false;
      cycle = true;
      sidebar-mode = false;
      hover-select = false;
      eh = 1;
      auto-select = false;
      parse-hosts = false;
      parse-known-hosts = true;
      combi-modi = "window,run";
      matching = "normal";
      tokenize = true;
      m = "-5";
      filter = "";
      dpi = -1;
      threads = 0;
      scroll-method = 0;
      window-format = "{w}    {c}   {t}";
      click-to-exit = true;
      max-history-size = 25;
      combi-hide-mode-prefix = false;
      combi-display-format = "{mode} {text}";
      matching-negate-char = "-";
      cache-dir = "";
      window-thumbnail = false;
      drun-use-desktop-cache = false;
      drun-reload-desktop-cache = false;
      normalize-match = false;
      steal-focus = false;
      application-fallback-icon = "";
      pid = "/run/user/1000/rofi.pid";
      display-window = "󰖯 Windows";
      display-windowcd = "󰖯 Windows";
      display-run = " Run";
      display-ssh = "󰣀 SSH";
      display-drun = " Apps";
      display-combi = " Combi";
      display-keys = " Keys";
      display-filebrowser = " Files";
      kb-primary-paste = "Control+V,Shift+Insert";
      kb-secondary-paste = "Control+v,Insert";
      kb-clear-line = "Control+w";
      kb-move-front = "Control+a";
      kb-move-end = "Control+e";
      kb-move-word-back = "Alt+b,Control+Left";
      kb-move-word-forward = "Alt+f,Control+Right";
      kb-move-char-back = "Left,Control+b";
      kb-move-char-forward = "Right,Control+f";
      kb-remove-word-back = "Control+Alt+h,Control+BackSpace";
      kb-remove-word-forward = "Control+Alt+d";
      kb-remove-char-forward = "Delete,Control+d";
      kb-remove-char-back = "BackSpace,Shift+BackSpace,Control+h";
      kb-remove-to-eol = "Control+k";
      kb-remove-to-sol = "Control+u";
      kb-accept-entry = "Control+j,Control+m,Return,KP_Enter";
      kb-accept-custom = "Control+Return";
      kb-accept-alt = "Shift+Return";
      kb-delete-entry = "Shift+Delete";
      kb-mode-next = "Shift+Right,Control+Tab";
      kb-mode-previous = "Shift+Left,Control+ISO_Left_Tab";
      kb-mode-complete = "Control+l";
      kb-row-left = "Control+Page_Up";
      kb-row-right = "Control+Page_Down";
      kb-row-up = "Up,Control+p";
      kb-row-down = "Down,Control+n";
      kb-row-tab = "Tab";
      kb-element-next = "";
      kb-element-prev = "";
      kb-page-prev = "Page_Up";
      kb-page-next = "Page_Down";
      kb-row-first = "Home,KP_Home";
      kb-row-last = "End,KP_End";
      kb-row-select = "Control+space";
      kb-screenshot = "Alt+S";
      kb-ellipsize = "Alt+period";
      kb-toggle-case-sensitivity = "grave,dead_grave";
      kb-toggle-sort = "Alt+grave";
      kb-cancel = "Escape,Control+g,Control+bracketleft";
      kb-custom-1 = "Alt+1";
      kb-custom-2 = "Alt+2";
      kb-custom-3 = "Alt+3";
      kb-custom-4 = "Alt+4";
      kb-custom-5 = "Alt+5";
      kb-custom-6 = "Alt+6";
      kb-custom-7 = "Alt+7";
      kb-custom-8 = "Alt+8";
      kb-custom-9 = "Alt+9";
      kb-custom-10 = "Alt+0";
      kb-custom-11 = "Alt+exclam";
      kb-custom-12 = "Alt+at";
      kb-custom-13 = "Alt+numbersign";
      kb-custom-14 = "Alt+dollar";
      kb-custom-15 = "Alt+percent";
      kb-custom-16 = "Alt+dead_circumflex";
      kb-custom-17 = "Alt+ampersand";
      kb-custom-18 = "Alt+asterisk";
      kb-custom-19 = "Alt+parenleft";
      kb-select-1 = "Super+1";
      kb-select-2 = "Super+2";
      kb-select-3 = "Super+3";
      kb-select-4 = "Super+4";
      kb-select-5 = "Super+5";
      kb-select-6 = "Super+6";
      kb-select-7 = "Super+7";
      kb-select-8 = "Super+8";
      kb-select-9 = "Super+9";
      kb-select-10 = "Super+0";
      ml-row-left = "ScrollLeft";
      ml-row-right = "ScrollRight";
      ml-row-up = "ScrollUp";
      ml-row-down = "ScrollDown";
      me-select-entry = "MousePrimary";
      me-accept-entry = "MouseDPrimary";
      me-accept-custom = "Control+MouseDPrimary";
    };
  };

  # Tema personalizado oscuro con estilo moderno
  # home.file.".config/rofi/config.rasi".text = ''
  #   configuration {
  #     font: "JetBrains Mono 12";
  #     display-drun: " Apps";
  #     display-run: " Run";
  #     display-window: " Windows";
  #     display-ssh: "󰣀 SSH";
  #     display-filebrowser: " Files";
  #     drun-display-format: "{name}";
  #     window-format: "{w} · {c} · {t}";
  #   }

  #   * {
  #     bg0: #1e1e2eff;
  #     bg1: #313244ff;
  #     bg2: #45475aff;
  #     bg3: #585b70ff;
  #     fg0: #cdd6f4ff;
  #     fg1: #bac2deff;
  #     fg2: #a6adc8ff;
  #     red: #f38ba8ff;
  #     green: #a6e3a1ff;
  #     yellow: #f9e2afff;
  #     blue: #89b4faff;
  #     magenta: #cba6f7ff;
  #     cyan: #94e2d5ff;

  #     accent: @blue;
  #     urgent: @red;

  #     background-color: transparent;
  #     text-color: @fg0;

  #     margin: 0;
  #     padding: 0;
  #     spacing: 0;
  #   }

  #   window {
  #     location: center;
  #     width: 640;
  #     border-radius: 12;
  #     background-color: @bg0;
  #     border: 2px;
  #     border-color: @accent;
  #   }

  #   mainbox {
  #     padding: 12;
  #   }

  #   inputbar {
  #     background-color: @bg1;
  #     border-color: @bg3;
  #     border: 2px;
  #     border-radius: 8;
  #     padding: 12px;
  #     spacing: 12px;
  #     children: [ prompt, entry ];
  #   }

  #   prompt {
  #     text-color: @accent;
  #   }

  #   entry {
  #     placeholder: "Search...";
  #     placeholder-color: @fg2;
  #   }

  #   message {
  #     margin: 12px 0 0;
  #     border-radius: 8;
  #     border-color: @bg1;
  #     background-color: @bg1;
  #   }

  #   textbox {
  #     padding: 12px;
  #     background-color: @bg1;
  #   }

  #   listview {
  #     background-color: transparent;
  #     margin: 12px 0 0;
  #     lines: 8;
  #     columns: 1;
  #     fixed-height: false;
  #     border: 0;
  #     scrollbar: true;
  #   }

  #   scrollbar {
  #     handle-width: 4px;
  #     handle-color: @accent;
  #     background-color: @bg2;
  #     border-radius: 8;
  #     margin: 0 0 0 4px;
  #   }

  #   element {
  #     padding: 10px;
  #     spacing: 12px;
  #     border-radius: 6;
  #     background-color: transparent;
  #     text-color: @fg0;
  #   }

  #   element normal normal {
  #     background-color: transparent;
  #     text-color: @fg0;
  #   }

  #   element normal urgent {
  #     background-color: @urgent;
  #     text-color: @bg0;
  #   }

  #   element normal active {
  #     background-color: @bg2;
  #     text-color: @accent;
  #   }

  #   element selected normal {
  #     background-color: @bg2;
  #     text-color: @accent;
  #     border: 0 0 0 3px solid;
  #     border-color: @accent;
  #   }

  #   element selected urgent {
  #     background-color: @urgent;
  #     text-color: @bg0;
  #   }

  #   element selected active {
  #     background-color: @bg2;
  #     text-color: @accent;
  #   }

  #   element alternate normal {
  #     background-color: transparent;
  #   }

  #   element-icon {
  #     size: 32;
  #     vertical-align: 0.5;
  #   }

  #   element-text {
  #     text-color: inherit;
  #     vertical-align: 0.5;
  #   }

  #   mode-switcher {
  #     spacing: 12;
  #     margin: 12px 0 0;
  #   }

  #   button {
  #     padding: 10px;
  #     border-radius: 6;
  #     background-color: @bg1;
  #     text-color: @fg1;
  #   }

  #   button selected {
  #     background-color: @accent;
  #     text-color: @bg0;
  #   }
  # '';
}
