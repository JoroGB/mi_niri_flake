{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.twilight

    inputs.niri-flake.homeModules.niri
    ./desktop/niri/niri_custom.nix

    inputs.noctalia.homeModules.default
    ./desktop/niri/noctalia.nix

    ./pkgs/fenix.nix
    ./pkgs/neovim.nix
    ./pkgs/obs.nix
    ./pkgs/rofi.nix
    ./pkgs/zellij.nix
    # ./desktop/hyprland/hyprland_custom.nix
    ./desktop/alacritty_config.nix
  ];
  programs = {
    zen-browser.enable = true;
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
      source = ./pkgs/config_files/config.nu;
      force = true;
    };

    "alacritty/alacritty.toml" = {
      force = true;
    };

    # "joronix/.profile" = {
    # force = true;
    # };

  };
  home.file.".profile".force = true;
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # hyprpaper
    # hyprlock
    # hypridle
    # hyprpicker

    # Launchers y notificaciones
    # rofi
    wofi
    waybar
    mako
    dunst

    # Screenshots
    grim
    slurp

    # Utils
    wl-clipboard
    pavucontrol

    # Temas
    adwaita-qt
    adwaita-qt6
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    gnome-themes-extra

    # Caracteres Japoneses, kanjins etec..
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Configuración de Qt para modo oscuro
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "Adwaita-Dark";
  };

  # Configuración de Hyprpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "desktop/niri/city_night.jpg" ];
      wallpaper = [ "desktop/niri/city_night.jpg" ];
      splash = false;
    };
  };
  # Configuración del cursor
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  # Asegurar que las variables de entorno se configuren
  home.sessionVariables = {
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    GTK_THEME = "Adwaita:dark";
    QT_STYLE_OVERRIDE = "Adwaita-Dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

}
