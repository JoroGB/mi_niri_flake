{
  writeShellApplication,
  azure-translate,
  paddle-ocr-stable,
  grim,
  slurp,
}:
writeShellApplication {
  name = "ocr-tr";
  runtimeInputs = [azure-translate paddle-ocr-stable grim slurp];

  text = ''
    from=""
    to=""
    raw=0

    while getopts "f:t:r" opt; do
      case $opt in
        f) from=$OPTARG ;;
        t) to=$OPTARG ;;
        r) raw=1 ;;
        *) echo "Uso: ocr-tr [-f origen] -t destino [-r]" >&2; exit 1 ;;
      esac
    done

    : "''${to:?Error: -t es obligatoria}"

    AZURE_KEY=$(tr -d '[:space:]' < "$HOME/.config/azure-tr/key.txt")
    PATH_OCR_IMAGE="$HOME/.config/azure-tr/data.png"

    grim -g "$(slurp)" "$PATH_OCR_IMAGE"
    TEXT_TO_TR=$(ocr -p "$PATH_OCR_IMAGE" | tr '\n' ' ')

    args=(-k "$AZURE_KEY" -t "$to")
    [ -n "$from" ] && args+=(-f "$from")
    [ "$raw" -eq 1 ] && args+=(-r)

    azure-translate "''${args[@]}" "$TEXT_TO_TR"
  '';
}
