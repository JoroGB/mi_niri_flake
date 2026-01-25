{ pkgs, ... }:

{
  # Configuración de OBS Studio con plugins
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      # Plugins esenciales
      obs-vaapi # Aceleración de hardware
      obs-vkcapture # Captura de Vulkan
      obs-pipewire-audio-capture # Captura de audio con PipeWire

      # Para Wayland/Niri (descomenta si usas Niri)
      wlrobs # Captura de pantalla en Wayland

      # Plugins adicionales opcionales
      # obs-backgroundremoval  # Remover fondo con IA
      # obs-webkitgtk  # Navegador web como fuente
      # obs-gstreamer  # Soporte para GStreamer
    ];
  };

  # Configuración de sesión para mejor compatibilidad
  home.sessionVariables = {
    # Para Wayland
    QT_QPA_PLATFORM = "wayland";
  };
}
