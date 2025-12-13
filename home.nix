{ config, pkgs, inputs, ... }:
{
  imports =[
    inputs.zen-browser.homeModules.twilight

    inputs.niri-flake.homeModules.niri
    ./desktop/niri/niri_custom.nix

    inputs.noctalia.homeModules.default
    ./desktop/niri/noctalia.nix

    ./programs/fenix.nix
    # ./programs/neovim.nix

    ./desktop/hyprland/hyprland_custom.nix
    ./desktop/alacritty_config.nix
  ];
  programs = {
    zen-browser.enable = true;
    git = {
      enable = true;
      userEmail = "134667974+JoroGB@users.noreply.github.com";
      userName = "JoroGB";
      settings = {
        init  = {
          defaultBranch = "main";
        };
      };
    };
  };

  home.username = "joronix";
  home.homeDirectory = "/home/joronix";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    hypridle
    hyprpicker

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
    playerctl
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
  home.sessionVariables.XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";

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

  # Variables de entorno
  home.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "Adwaita-Dark";
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

}
