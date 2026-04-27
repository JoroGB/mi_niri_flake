{
  pkgs,
  fetchurl,
  appimageTools,
  ...
}: let
  pname = "minecraft-bedrock";
  version = "1.1.1-802"; # Verifica la última versión
  icon = pkgs.fetchurl {
    url = "https://cdn.worldvectorlogo.com/logos/minecraft-launcher.svg";
  };
in
  appimageTools.wrapType2 {
    inherit pname version;

    # src = fetchurl {
    #   url = "https://github.com/minecraft-linux/appimage-builder/releases/download/v1.1.1-802/Minecraft_Bedrock_Launcher-x86_64-v1.1.1.802.AppImage";
    #   sha256 = ""; # Necesitas calcular el hash
    # };

    extraInstallCommands = ''
          # Crea los directorios necesarios
          mkdir -p $out/share/applications
          mkdir -p $out/share/icons/hicolor/256x256/apps

          # Instala el icono desde el mismo directorio
          install -Dm644 ${icon} $out/share/icons/hicolor/256x256/apps/${pname}.svg

          # Crea el archivo .desktop
          cat > $out/share/applications/${pname}.desktop <<EOF
      [Desktop Entry]
      Name=Pear Minecraft-bedrock-Launcher
      Comment=Minecraft bedrock for nixos
      Exec=$out/bin/${pname} %U
      Icon=${icon}
      Terminal=false
      Type=Application
      Categories=Games
      StartupNotify=true
      EOF
    '';
  }
