{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    protonplus
    yad
    xdotool
    xwininfo

    steamtinkerlaunch
    protontricks
    winetricks
    wineWow64Packages.stable
    gnutls
  ];

  shellHook = ''
    echo "ARCHIVO DE PROGRAMAS Y VARIABLE DE ENTORNO PARA INSTALAR RELOADED-II"
    echo "REQUISITOS"
    echo "--Paquetes"
    echo "protonplus : para instalar GE-PROTON (Funciona mejor con persona)
          protontricks : para hacer una instalacion mas limpias de las dependencias que se veran mas adelante
          wine64: o wineWow64Packages las dependencias que se requieren dependen de wine
        "
    echo "--Ejecutables"
    echo ".Net: Requerido por RELOADED-II se requiere .NET Desktop Runtime
          se puede conseguie en https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-desktop-8.0.26-windows-x64-installer

          reloaded-ii: Mod loader (Setup-Linux.exe)
          se puede conseguir en https://github.com/Reloaded-Project/Reloaded-II/releases/latest/download/Setup-Linux.exe
        "
    echo "--Variables de entorno"
    echo "WINEPREFIX: Cada juego tiene de manera independien un directorio en el que se alojan las dependencias de windows
          se encuentra en /Steam/steamapps/compatdata/<id_juego>/pfx/
          el <id_juego> se puede saber en la pagina oficial de steam del juego
          en este caso seria
    "
    echo "WINEPREFIX=/home/joronix/.local/share/Steam/steamapps/compatdata/1687950/pfx"
    export WINEPREFIX="/home/joronix/.local/share/Steam/steamapps/compatdata/1687950/pfx/" \
    echo "INSTALCION"
    echo "Se requiere previamente abrir el juego para que proton haga el directorio /pfx"
    echo "se define la variable de entorno y luego"
    echo "protontricks-launch --appid 1687950 /<path_to>/runtime-desktop-8.exe"
    echo "se instala .net (runtime-desktop-8.x.exe) con protontricks"
    echo "Terminada la instalacion se puede instalar RELOADED-II"
    echo "protontricks-launch --appid 1687950 ~/<path_to>/Setup-Linux.exe"
    echo "Listo! se iniciara de primera instacia el mod loader, para volver abrir se localizaria el ejecutable "
    echo "Por lo que noto se suele instalar en /home/<usuario>/Desktop/<reloaded-ii>"
    echo "wine /home/joronix/Desktop/Reloaded-II - P5R/Reloaded-II.exe"
  '';
}

