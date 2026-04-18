{...}: {
  programs.kitty = {
    enable = true;

    # --- Fuente ---
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    # --- Configuración general (colores, apariencia, etc.) ---
    settings = {
      # Colores de fondo y texto
      background = "#010502"; # o cualquier hex
      foreground = "#cdd6f4";
      selection_background = "#313244";
      selection_foreground = "#cdd6f4";
      # Transparencia (0.0 = opaco, 1.0 = invisible)
      background_opacity = "0.85";

      # Colores de cursor
      cursor = "#f5e0dc";
      cursor_text_color = "#1e1e2e";

      # Padding interior de la ventana
      window_padding_width = 0;

      # Scroll
      scrollback_lines = 10000;

      # Bell
      enable_audio_bell = false;

      # Cursor
      cursor_shape = "block"; # block | beam | underline
      cursor_blink_interval = "0"; # 0 = sin parpadeo
    };

    # --- Keybindings ---
    # Formato: "mod+key" = "acción";
    # Para desactivar un keybind por defecto: "mod+key" = "no_op";
    keybindings = {
      # Nuevas ventanas/tabs
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";

      # Navegar entre tabs
      "ctrl+shift+l" = "next_tab";
      "ctrl+shift+h" = "previous_tab";
      "ctrl+shift+n" = "";

      # Navegar entre ventanas (splits)
      "ctrl+shift+j" = "neighboring_window down";
      "ctrl+shift+k" = "neighboring_window up";

      # Zoom a ventana activa
      "ctrl+shift+z" = "toggle_layout stack";

      # Copiar/pegar
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+insert" = "copy_to_clipboard";
      "shift+insert" = "paste_from_clipboard";
      # Cambiar tamaño de fuente
      "ctrl+equal" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0"; # reset
    };
  };
}
