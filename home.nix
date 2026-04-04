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

    inputs.noctalia.homeModules.default
    ./pkgs/noctalia.nix
    ./pkgs/fenix.nix
    ./pkgs/neovim.nix
    ./pkgs/obs.nix
    ./pkgs/rofi.nix
    ./pkgs/zellij.nix
    ./pkgs/alacritty_config.nix
    ./pkgs/kitty.nix
  ];
  programs = {
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
  home.file.".profile".force = true;
  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    onlyoffice-desktopeditors
    # wallpaper
    linux-wallpaperengine
    # Launchers y notificaciones
    wofi
    # Utils
    pavucontrol

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
  ];
  services.mako.enable = false;

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
