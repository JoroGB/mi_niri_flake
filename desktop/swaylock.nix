{ pkgs, inputs, ... }:{
  programs.swaylock = {
    enable = true;
    settings = {
      # Fondo gris oscuro de Tokyo Night
      color = "1a1b26";

      # Indicador
      indicator-radius = 120;
      indicator-thickness = 8;
      indicator-idle-visible = false;

      # Colores del anillo (azul Tokyo Night)
      ring-color = "414868";
      ring-ver-color = "7aa2f7";
      ring-wrong-color = "f7768e";
      ring-clear-color = "9ece6a";

      # Interior del indicador
      inside-color = "24283b";
      inside-ver-color = "24283b";
      inside-wrong-color = "24283b";
      inside-clear-color = "24283b";

      # Línea separadora
      line-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      line-clear-color = "00000000";

      # Texto
      text-color = "c0caf5";
      text-ver-color = "c0caf5";
      text-wrong-color = "f7768e";
      text-clear-color = "c0caf5";

      # Otros
      font = "sans-serif";
      font-size = 14;
      show-failed-attempts = true;
      show-keyboard-layout = true;
      grace = 2;
      fade-in = 0.2;
    };
  };
}
