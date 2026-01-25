{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    # Tema
    theme = "Arc-Dark";

    # O un tema personalizado
    # theme = ./mi-tema-rofi.rasi;

    # Terminal que usa rofi
    terminal = "${pkgs.alacritty}/bin/alacritty";

    # Configuración extra en formato rasi
    extraConfig = {
      modi = "drun,run,window,ssh";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };

    # Plugins adicionales
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];
  };
}
