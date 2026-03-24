{
  config,
  pkgs,
  ...
}: {
  # home.nix
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      modi = "drun";
      show-icons = true;
      drun-display-format = "{name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "  Apps";
      icon-theme = "Papirus-Dark";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#010502";
        bg-alt = mkLiteral "#343f44";
        fg = mkLiteral "#d3c6aa";
        fg-alt = mkLiteral "#859289";
        accent = mkLiteral "#2d353b";
        urgent = mkLiteral "#e67e80";

        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
        font = "JetBrainsMono Nerd Font 12";
        border = 0;
        margin = 0;
        padding = 0;
        spacing = 0;
      };

      "window" = {
        background-color = mkLiteral "rgba(3,15,6,0.90)";
        width = mkLiteral "30%";
        border-radius = mkLiteral "12px";
        padding = mkLiteral "16px";
      };

      "inputbar" = {
        background-color = mkLiteral "@bg";
        border-radius = mkLiteral "8px";
        padding = mkLiteral "8px 12px";
        margin = mkLiteral "0 0 12px 0";
        children = mkLiteral "[prompt, entry]";
      };

      "prompt" = {
        text-color = mkLiteral "@bg-alt";
        margin = mkLiteral "0 8px 0 0";
      };

      "entry" = {
        text-color = mkLiteral "@fg";
        placeholder = "Buscar...";
        placeholder-color = mkLiteral "@fg-alt";
      };

      "listview" = {
        lines = 8;
        columns = 1;
        spacing = mkLiteral "4px";
      };

      "element" = {
        border-radius = mkLiteral "6px";
        padding = mkLiteral "8px 12px";
        orientation = mkLiteral "horizontal";
        spacing = mkLiteral "8px";
      };

      "element normal normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg";
      };

      "element normal urgent" = {
        text-color = mkLiteral "@urgent";
      };

      "element selected normal" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg";
      };

      "element-icon" = {
        size = mkLiteral "24px";
      };

      "element-text" = {
        vertical-align = mkLiteral "0.5";
      };
    };
  };
}
