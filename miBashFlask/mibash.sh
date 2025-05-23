

TTS_AUTO=0



process_command() {
    cmd="$1"; shift
    case "$cmd" in
        install_app)       install_app   "$@" ;;
        uninstall_app)     uninstall_app "$@" ;;
        img_to_ascii)      img_to_ascii  "$@" ;;
        mini_game_1)       mini_game_1       ;;
        minigame2)         minigame2         ;;
        kill_process)      kill_process  "$@" ;;
        show_pid)          show_pid      "$@" ;;
        show_date)         show_date         ;;
        clima)             clima         "$@" ;;
        alias)             alias_command "$@" ;;
        help)              show_help         ;;
        show_about)             show_about        ;;
        call)             call_number "$@";;
        *)                 echo "Comando desconocido: $cmd"; show_help ;;
    esac
}


# Función para abrir la llamada
call_number() {
  local num="$1"
  [ -z "$num" ] && { echo "Uso: make_call <teléfono>"; return 1; }
  echo "Llamando a $num…"
  if command -v xdg-open >/dev/null; then
    xdg-open "tel:$num"
  elif command -v open >/dev/null; then
    open   "tel://$num"
  else
    echo "Error: no se puede iniciar la llamada." >&2
    return 1
  fi
}
show_help() {
    cat <<EOF
Comandos disponibles:
  install_app NOMBRE       Instala un paquete
  uninstall_app NOMBRE     Desinstala un paquete
  img_to_ascii RUTA        Convierte imagen a ASCII
  mini_game_1              Space Invaders
  minigame2                Adivina el número
  kill_process PID         Mata un proceso
  show_pid PID             Muestra detalles del proceso
  show_date                Fecha y hora actuales
  clima CIUDAD             Clima (wttr.in)
  alias ALIAS [ARGS...]    Ejecuta un alias
  help                     Esta ayuda
  about                    Acerca del script
EOF
}




text_to_speech() {
    if [ "$TTS_AUTO" -eq 1 ]; then
        if command -v say >/dev/null 2>&1; then
            say "$1"
        elif command -v espeak >/dev/null 2>&1; then
            espeak "$1"
        fi
    fi
}

alias_command() {
    # Ejemplo de alias
    case "$1" in
        listar) command ls "${@:2}" ;;
        df) command df -h "${@:2}" ;;
        eliminar) command rm "${@:2}";;
        *) echo "Alias no encontrado: $1" ;;
    esac
}

install_app() {
    sudo apt-get update && sudo apt-get install -y "$1"
}

uninstall_app() {
    sudo apt-get remove -y "$1"
}

mini_game_1() {
    ninvaders
}

minigame2() {
    # Adivina el número (ejemplo simple)
    target=$((RANDOM % 100 + 1))
    echo "Adivina el número entre 1 y 100"
    while read -p "> " guess; do
        if (( guess < target )); then
            echo "Más alto"
        elif (( guess > target )); then
            echo "Más bajo"
        else
            echo "¡Correcto!"
            break
        fi
    done
}



show_about() {
    echo "Shell interactiva simplificada — funciones disponibles sin animaciones"
}

show_date() {
    date '+%Y-%m-%d %H:%M:%S'
}

kill_process() {
    kill -9 "$1" && echo "Proceso $1 eliminado"
}

show_pid() {
   # ps aux
    ps -p "$1" -f
}

clima() {
    curl -s "wttr.in/${1:-}?format=3"
}

img_to_ascii() {
    if ! command -v img2txt >/dev/null; then
        echo "Error: necesitas instalar libcaca-utils (img2txt)"
        return 1
    fi
    img2txt --width=80 "$1"
}



# ----------------------------------------
# Dispatcher: si el script se invoca directamente,
# llama a process_command con todos los parámetros
# ----------------------------------------
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  process_command "$@"
fi
