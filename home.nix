{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.niri-flake.homeModules.niri
    ./pkgs/niri_custom.nix
    inputs.mangowm.hmModules.mango
    ./pkgs/mango.nix

    inputs.noctalia.homeModules.default
    ./pkgs/noctalia.nix
    ./pkgs/fenix.nix
    ./pkgs/neovim.nix
    ./pkgs/obs.nix
    ./pkgs/rofi.nix
    ./pkgs/zellij.nix
    ./pkgs/alacritty_config.nix
    ./pkgs/kitty.nix
    ./pkgs/dot-desktop.nix
    # ./pkgs/waybar.nix
    # ./pkgs/minecraft-bedrock.nix
  ];
  home.file.".profile".force = true;
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    #productividad
    clipse
    onlyoffice-desktopeditors
    opencode
    foliate
    obsidian
    super-productivity
    krita
    # wallpaper
    awww
    mpvpaper
    # inputs.pc_control.packages.${pkgs.system}.default

    # Launchers y notificaciones
    wofi
    libnotify
    swaynotificationcenter
    prismlauncher

    # audio
    pavucontrol
    osu-lazer-bin

    # Temas
    adwaita-qt
    adwaita-qt6
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    gnome-themes-extra
    papirus-icon-theme
    # Caracteres Japoneses, kanjins etec..
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    (callPackage ./pkgs/zennotes.nix {})
    (python3.withPackages (ps:
      with ps; [
        pypinyin
        jupyter-client
        pynvim
        ipykernel
        jupytext
        # tus libs de trabajo: numpy, pandas, matplotlib, etc.
        numpy
        pandas
        matplotlib
      ]))
    (pkgs.writeShellApplication {
      name = "pinyin";
      runtimeInputs = [(pkgs.python3.withPackages (ps: [ps.pypinyin]))];
      text = ''
              if [ $# -gt 0 ]; then
                input="$*"
              else
                input="$(cat)"
              fi
              python -c 'import sys
        from pypinyin import pinyin
        print(" ".join(s[0] for s in pinyin(sys.argv[1])))' "$input"
      '';
    })
  ];

  services.mako.enable = false;
  services.clipse = {
    enable = true;
    settings = {
      allowDuplicates = false;
      maxHistory = 100;
      imageDisplay = {
        type = "sixel";
        scaleX = 9;
        scaleY = 9;
        heightCut = 2;
      };
    };
  };
  programs = {
    nushell = {
      extraEnv = ''
        $env.STEAM_API_KEY = "tu_key_aqui"
        $env.PRUEBA_DE_ENV = "prueba de contenido"
      '';
    };
    chromium = {
      enable = true;
    };
    zen-browser = {
      enable = true;
    };
    git = {
      enable = true;
      settings = {
        user = {
          name = "JoroGB";
          email = "134667974+JoroGB@users.noreply.github.com";
        };
        init = {
          defaultBranch = "main";
        };
      };
    };
    bash = {
      enable = true;
      historyControl = [
        "ignoredups"
        "ignorespace"
      ];
      initExtra = ''
        shopt -u histappend
      '';
    };
  };

  xdg.configFile = {
    "nushell/config.nu" = {
      source = ./pkgs/config_files/nushell/config.nu;
      force = true;
    };

    "alacritty/alacritty.toml" = {
      force = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # dimitir evaluation warning
  gtk.gtk4.theme = config.gtk.theme;
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk"; # Qt mira el tema GTK activo
  #   style = {
  #     name = "adwaita-dark";
  #     package = pkgs.adwaita-qt;
  #   };
  # };

  # Configuración del cursor
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
  xdg.configFile = {
    "fcitx5/profile" = {
      text = ''
        [Groups/0]
        Name=Default
        Default Layout=us
        DefaultIM=pinyin

        [Groups/0/Items/0]
        Name=keyboard-us
        Layout=

        [Groups/0/Items/1]
        Name=pinyin
        Layout=

        [GroupOrder]
        0=Default
      '';
      force = true;
    };
  };
  home.sessionPath = ["$HOME/.local/bin"];
  home.sessionVariables = {
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "Adwaita-Dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };
  home.file.".local/bin/clipboard-pick".text = ''
    #!/bin/sh
    cliphist list | rofi -dmenu -display-columns 2 -location 7 -xoffset 10 -yoffset -10 | cliphist decode | wl-copy
  '';
  home.file.".local/bin/clipboard-pick".executable = true;
}
