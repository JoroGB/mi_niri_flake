{
  lib,
  appimageTools,
  fetchurl,
}: let
  version = "2.3.0";
  pname = "ZenNotes";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://github.com/ZenNotes/zennotes/releases/download/v${version}/ZenNotes-${version}-linux-x86_64.AppImage";
    hash = "sha256:22f1462bb9f72905461139adea1414cbe6d935338291fbb01fc89f978293c71c";
  };

  appimageContents = appimageTools.extractType1 {inherit pname version src;};
in
  appimageTools.wrapType2 rec {
    inherit name pname version src;

    extraInstallCommands = ''

      install -m 444 -D ${appimageContents}/${pname}.desktop $out/share/applications/${pname}.desktop

      install -m 444 -D ${appimageContents}/${pname}.png $out/share/icons/hicolor/512x512/apps/${pname}.png
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    '';

    meta = {
      description = "Keyboard-first local Markdown notes with Vim motions, diagrams, and MCP integration";
      homepage = "https://github.com/ZenNotes/zennotes";
      downloadPage = "https://github.com/ZenNotes/zennotes/releases";
      license = lib.licenses.mit;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      # maintainers = with lib.maintainers; [];
      platforms = ["x86_64-linux"];
    };
  }
