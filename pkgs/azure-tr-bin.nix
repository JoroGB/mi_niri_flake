{
  writeShellApplication,
  curl,
  jq,
}:
writeShellApplication {
  name = "azure-translate";
  runtimeInputs = [curl jq];

  text = ''
    endpoint="https://api.cognitive.microsofttranslator.com/translate"
    location="eastus"

    usage() {
      cat <<'EOF'
    Uso: azure-translate [-f origen] -t destino [-k api_key] [-r] [texto...]

      -f  idioma de origen (por defecto: auto-detección)
      -t  idioma de destino (obligatorio), ej: es, en, zh-Hans
      -k  API key (o usa la variable AZURE_TRANSLATOR_KEY)
      -r  imprime solo el texto traducido en vez del JSON completo

    Si no se pasa texto como argumento, se lee de stdin.
    EOF
    }

    from="auto"
    to=""
    key="''${AZURE_TRANSLATOR_KEY:-}"
    raw=0

    while getopts "f:t:k:rh" opt; do
      case $opt in
        f) from=$OPTARG ;;
        t) to=$OPTARG ;;
        k) key=$OPTARG ;;
        r) raw=1 ;;
        h) usage; exit 0 ;;
        *) usage; exit 1 ;;
      esac
    done
    shift $((OPTIND - 1))

    if [ -z "$to" ] || [ -z "$key" ]; then
      usage
      exit 1
    fi

    if [ $# -gt 0 ]; then
      text="$*"
    else
      text=$(cat)
    fi

    body=$(jq -n --arg t "$text" '[{text: $t}]')

    from_args=()
    if [ "$from" != "auto" ]; then
      from_args=(--url-query "from=$from")
    fi

    response=$(curl --silent --show-error --fail-with-body \
      -X POST "$endpoint" \
      --url-query "api-version=3.0" \
      "''${from_args[@]}" \
      --url-query "to=$to" \
      -H "Ocp-Apim-Subscription-Key: $key" \
      -H "Ocp-Apim-Subscription-Region: $location" \
      -H "Content-Type: application/json" \
      -H "X-ClientTraceId: $(cat /proc/sys/kernel/random/uuid)" \
      --data "$body")

    if [ "$raw" -eq 1 ]; then
      jq -r '.[0].translations[0].text' <<<"$response"
    else
      jq . <<<"$response"
    fi
  '';
}
