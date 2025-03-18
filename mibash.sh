#!/bin/bash
# mi_shell.sh - Shell interactiva con múltiples funcionalidades:
# - Instalación/desinstalación de ficheros y directorios.
# - Conversión de imágenes a ASCII (usando libcaca con ultra alta resolución reducida).
# - Efectos visuales: máquina de escribir, fractales, visualización del clima.
# - Minijuegos: Space Invaders (ninvaders) y otro (adivina número).
# - Funciones de Text-to-Speech (TTS) opcional.
# - Animación de bienvenida con un loro sujetando un banner.
# - Espectáculo de cierre con pingüinos y fuegos artificiales.
# - Función de emergencia que inicia una llamada telefónica a un número predefinido.


########################################
# Variable TTS_AUTO: se activa según elección del usuario
########################################
TTS_AUTO=0

########################################
# Función: Text-to-Speech (TTS)
########################################
text_to_speech() {
    if command -v say >/dev/null 2>&1; then
        say "$*"
    elif command -v espeak >/dev/null 2>&1; then
        espeak "$*"
    else
        echo "Text-to-Speech no disponible."
    fi
}

########################################
# Función: Animación de Welcome Banner
# Muestra un loro sujetando un banner con el texto "WELCOME TO S-HELL"
########################################
welcome_banner() {
    local frame1="         
         ,_____.
        /       \\
       |  (O.O)  |
        \\  /\\   /
         \\ \\/  /
          \`--\'
[ WELCOME TO S-HELL ]"
    local frame2="         
         ,_____.
        /       \\
       |  (o.o)  |
        \\  \\/   /
         \\ /\\  /
          \`--\'
*WELCOME TO S-HELL!*"
    for i in {1..6}; do
        clear
        if [ $(( i % 2 )) -eq 0 ]; then
            echo -e "$frame1"
        else
            echo -e "$frame2"
        fi
        sleep 0.5
    done
    clear
    if [ "$TTS_AUTO" -eq 1 ]; then
        text_to_speech "Bienvenido, su shell interactiva está lista."
    fi
}
alias_command() {
    echo -e "\033[1;34m┌───────────────────────────────┬───────────────────────────────┐\033[0m"
    echo -e "\033[1;34m│ \033[1;33mComando Original              \033[1;34m│ \033[1;33mAlias                        \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🔄 cd                         \033[1;34m│ \033[1;36mcambiardir                   \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m👀 cat                        \033[1;34m│ \033[1;36mver                          \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📁 mkdir                      \033[1;34m│ \033[1;36mcreardir                    \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📂 /                          \033[1;34m│ \033[1;36macceder a otro directorio    \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🌳 tree                       \033[1;34m│ \033[1;36mesquema                     \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📑 touch                      \033[1;34m│ \033[1;36mcreararch                   \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📝 nano                       \033[1;34m│ \033[1;36meditor                      \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📋 man nombrecomando          \033[1;34m│ \033[1;36mmanual                      \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📚 ls -lrt                    \033[1;34m│ \033[1;36mlistartodo                  \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🔀 mv                         \033[1;34m│ \033[1;36mmover                       \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m♻️ 📁 rmdir o rm -rf           \033[1;34m│ \033[1;36mborrardir                   \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m♻️ 📑 rm                      \033[1;34m│ \033[1;36mborrararch                  \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📍 pwd                        \033[1;34m│ \033[1;36mubi                         \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🆑 clear                      \033[1;34m│ \033[1;36mlimpiar                     \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📜 history                    \033[1;34m│ \033[1;36mhistorial                   \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📢 echo '...' >               \033[1;34m│ \033[1;36mecosobre '...'              \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📢 echo '...' >>              \033[1;34m│ \033[1;36meconueva '...'              \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m❓ file                       \033[1;34m│ \033[1;36mtipoarch                    \033[1;34m│\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🌐 wget                       \033[1;34m│ \033[1;36mdesweb                      \033[1;34m│\033[0m"
    echo -e "\033[1;34m└───────────────────────────────┴───────────────────────────────┘\033[0m"
}
########################################
# Función: espectáculo de cierre con pingüinos (exit_show)
########################################
exit_show() {
    clear
    echo "¡El espectáculo de pingüinos está llegando a su fin!"
    if [ "$TTS_AUTO" -eq 1 ]; then
        text_to_speech "El espectáculo de pingüinos está llegando a su fin."
    fi
    sleep 1
    if command -v afplay >/dev/null 2>&1 && [ -f /System/Library/Sounds/Sosumi.aiff ]; then
        afplay /System/Library/Sounds/Sosumi.aiff &
    fi
    sleep 1
    for i in {1..5}; do
        clear
        case $i in
            1)
                echo -e "\033[1;37m   _~_      _~_      _~_ \033[0m"
                echo -e "\033[1;30m  (o o)    (o o)    (o o)\033[0m"
                echo -e "\033[1;34m  / V \\    / V \\    / V \\  ¡Los pingüinos se preparan!\033[0m"
                ;;
            2)
                echo -e "\033[1;37m   _~_      _~_      _~_ \033[0m"
                echo -e "\033[1;30m  (o o)    (o o)    (o o)\033[0m"
                echo -e "\033[1;34m  / V \\    / V \\    / V \\  ¡Empiezan a bailar!\033[0m"
                ;;
            3)
                echo -e "\033[1;31m   🎩      🎩      🎩 \033[0m"
                echo -e "\033[1;37m   _~_      _~_      _~_ \033[0m"
                echo -e "\033[1;30m  (O O)    (O O)    (O O)\033[0m"
                echo -e "\033[1;34m  / V \\    / V \\    / V \\  ¡El espectáculo está en marcha!\033[0m"
                ;;
            4)
                echo -e "\033[1;37m   _~_      _~_      _~_ \033[0m"
                echo -e "\033[1;30m  (o o)    (o o)    (o o)\033[0m"
                echo -e "\033[1;34m  / V \\    / V \\    / V \\  ¡Aplausos, aplausos!\033[0m"
                ;;
            5)
                echo -e "\033[1;31m   🎩      🎩      🎩 \033[0m"
                echo -e "\033[1;37m   _~_      _~_      _~_ \033[0m"
                echo -e "\033[1;30m  (o o)    (o o)    (o o)\033[0m"
                echo -e "\033[1;34m  / V \\    / V \\    / V \\  ¡Hasta la próxima, amigos!\033[0m"
                ;;
        esac
        sleep 0.7
    done
    clear
    echo -e "\033[1;32m¡Gracias por asistir al espectáculo de pingüinos!\033[0m"
    if [ "$TTS_AUTO" -eq 1 ]; then
        text_to_speech "Gracias por asistir al espectáculo de pingüinos. Hasta la próxima."
    fi
    sleep 2
    exit 0
}

########################################
# Función: ASCII Fireworks (para mindblow)
########################################
fireworks() {
    local frames=(
"\033[1;31m         *\033[0m
\033[1;33m        * *\033[0m
\033[1;31m         *\033[0m"
"\033[1;31m       \\ | /\033[0m
\033[1;33m     --  *  --\033[0m
\033[1;31m       / | \\\033[0m"
"\033[1;33m    *   *   *\033[0m
\033[1;31m   *  *   *  *\033[0m
\033[1;33m    *   *   *\033[0m"
"\033[1;31m      *  *  *  *\033[0m
\033[1;33m   *    *   *    *\033[0m
\033[1;31m      *  *  *  *\033[0m"
"\033[1;33m   * * *     * * *\033[0m
\033[1;31m  *     *   *     *\033[0m
\033[1;33m   * * *     * * *\033[0m"
"\033[1;31m *   *   *   *   *   *\033[0m
\033[1;33m   *   *   *   *   *\033[0m
\033[1;31m *   *   *   *   *   *\033[0m"
    )
    for frame in "${frames[@]}"; do
        clear
        echo -e "$frame"
        sleep 0.3
    done
    clear
}

########################################
# Función: Emergencia (llamada telefónica)
########################################
emergencia() {
    clear
    echo -e "\033[1;31m🚨🚨🚨 ¡¡EMERGENCIA!! 🚨🚨🚨\033[0m"
    echo -e "\033[1;33mLlamando a tu familiar de emergencia...\033[0m"
    if command -v open >/dev/null 2>&1; then
        # Reemplaza +(número default) con el número real (incluyendo código de país)
        open "tel://+34 618239254"
    else
        echo -e "\033[1;31m⚠️ No se pudo iniciar la llamada (comando 'open' no disponible).\033[0m"
    fi
    echo -e "\033[1;32mPor favor, mantén la calma mientras se realiza la llamada.\033[0m"
}

########################################
# Funciones de sonido (Sonidos de Apple)
########################################
play_success_sound() {
    echo "😊 Comando ejecutado correctamente!"
    if [ "$TTS_AUTO" -eq 1 ]; then
        text_to_speech "Comando ejecutado correctamente."
    fi
    if command -v afplay >/dev/null 2>&1 && [ -f /System/Library/Sounds/Glass.aiff ]; then
        afplay /System/Library/Sounds/Glass.aiff
    else
        echo -e "\a"
    fi
}

play_error_sound() {
    echo "😞 Error en la ejecución del comando."
    if [ "$TTS_AUTO" -eq 1 ]; then
        text_to_speech "Error en la ejecución del comando."
    fi
    if command -v afplay >/dev/null 2>&1 && [ -f /System/Library/Sounds/Sosumi.aiff ]; then
        afplay /System/Library/Sounds/Sosumi.aiff
    else
        echo -e "\a"
    fi
}

########################################
# Funciones de instalación/desinstalación
########################################
install_app() {
    echo "[INSTALL] Iniciando proceso de instalación..."
    mkdir -p ~/mi_instalacion/dir1 ~/mi_instalacion/dir2
    touch ~/mi_instalacion/dir1/archivo1.txt ~/mi_instalacion/dir2/archivo2.txt
    echo "[INSTALL] Directorios y archivos creados."
    echo "[INSTALL] Proceso de instalación completado."
    return 0
}

uninstall_app() {
    echo "[UNINSTALL] Iniciando proceso de desinstalación..."
    rm -rf ~/mi_instalacion
    echo "[UNINSTALL] Directorios y archivos eliminados."
    echo "[UNINSTALL] Proceso de desinstalación completado."
    return 0
}

########################################
# Otras funciones (mini juego, ayuda, etc.)
########################################
mini_game_1() {
    echo "[MINI-GAME-1] Bienvenido al mini juego: Adivina un número entre 1 y 5"
    numero=$(( RANDOM % 5 + 1 ))
    read -p "Introduce tu número: " respuesta
    if [ "$respuesta" -eq "$numero" ]; then
        echo "[MINI-GAME-1] ¡Felicidades! Has adivinado."
        return 0
    else
        echo "[MINI-GAME-1] Lo siento, el número correcto era $numero."
        return 1
    fi
}

show_help() {
    echo -e "\033[1;34m┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐\033[0m"
    echo -e "\033[1;34m│ \033[1;33mComando                        \033[1;34m│ \033[1;33mDescripción                                                       \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┬───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📥 install                     \033[1;34m│ \033[1;36mInstala directorios y archivos de ejemplo.                        \033[0m"
    echo -e "\033[1;34m│                               \033[1;34m│ \033[1;36mIdeal para configurar el entorno inicial.                         \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🗑️ uninstall                   \033[1;34m│ \033[1;36mElimina los directorios y archivos instalados.                    \033[0m"
    echo -e "\033[1;34m│                               \033[1;34m│ \033[1;36mÚtil para limpiar el entorno.                                     \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🎲 mini-game-1                 \033[1;34m│ \033[1;36mJuego de adivinar un número entre 1 y 5.                          \033[0m"
    echo -e "\033[1;34m│                               \033[1;34m│ \033[1;36m¡Pon a prueba tu suerte!                                          \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m❓ help                        \033[1;34m│ \033[1;36mMuestra esta tabla de ayuda con los comandos disponibles.          \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32mℹ️ about                      \033[1;34m│ \033[1;36mMuestra información sobre los desarrolladores del proyecto.        \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m📅 fecha                      \033[1;34m│ \033[1;36mMuestra la fecha y hora actual.                                   \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🐱 dibujito                   \033[1;34m│ \033[1;36mMuestra un dibujo ASCII de un gato.                               \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🔪 kill-process               \033[1;34m│ \033[1;36mFinaliza un proceso dado su PID.                                  \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🆔 pid                        \033[1;34m│ \033[1;36mMuestra el PID del script actual.                                 \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🎆 mindblow                   \033[1;34m│ \033[1;36mLanza un proceso hijo que muestra fuegos artificiales ASCII.      \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🖼️ img2ascii                  \033[1;34m│ \033[1;36mConvierte una imagen a arte ASCII.                                \033[0m"
    echo -e "\033[1;34m│                               \033[1;34m│ \033[1;36m(Requiere herramientas externas como libcaca o jp2a).             \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m⌨️ typewriter                 \033[1;34m│ \033[1;36mMuestra texto con efecto de máquina de escribir.                 \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🌀 fractales                  \033[1;34m│ \033[1;36mGenera un fractal de Mandelbrot en ASCII.                        \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🌦️ clima                     \033[1;34m│ \033[1;36mMuestra el clima actual usando wttr.in.                          \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m👾 minigame2                 \033[1;34m│ \033[1;36mLanza el juego Space Invaders (requiere ninvaders).              \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🗣️ tts                       \033[1;34m│ \033[1;36mConvierte texto a voz usando herramientas disponibles.            \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🚨 emergencia                \033[1;34m│ \033[1;36mInicia una llamada de emergencia a un número predefinido.         \033[1;34m│\033[0m"
    echo -e "\033[1;34m├───────────────────────────────┼───────────────────────────────────────────────────────────────────────────────┤\033[0m"
    echo -e "\033[1;34m│ \033[1;32m🐧 exit                      \033[1;34m│ \033[1;36mMuestra un espectáculo de pingüinos y cierra el script.          \033[1;34m│\033[0m"
    echo -e "\033[1;34m└───────────────────────────────┴───────────────────────────────────────────────────────────────────────────────┘\033[0m"
    return 0
}

show_about() {
    if [ -f "./aboutUs.html" ]; then
        lynx ./aboutUs.html
    else 
        echo "[ABOUT] Este es un proyecto de shell interactiva desarrollado por Camila Montoya,Hugo García,Florentin Delgado y Javier Gutiérrez."

    fi
    return 0
}

show_date() {
    echo "[FECHA] La fecha y hora actual es:"
    date
    return 0
}

show_dibujito() {
    echo "[DIBUJITO]"
    echo "   /\_/\  "
    echo "  ( o.o ) "
    echo "   > ^ <  "
    return 0
}

kill_process() {
    local target_pid="$1"
    if [ -z "$target_pid" ]; then
        read -p "[KILL-PROCESS] Introduce el PID del proceso a matar: " target_pid
    fi
    if kill -0 "$target_pid" 2>/dev/null; then
        kill -9 "$target_pid"
        echo "[KILL-PROCESS] Proceso $target_pid finalizado."
        return 0
    else
        echo "[KILL-PROCESS] No se encontró un proceso con PID $target_pid."
        return 1
    fi
}

show_pid() {
    echo "[PID] El PID de este script es: $$"
    return 0
}

# Mindblow con fuegos artificiales
mindblow() {
    echo "[MINDBLOW] Creando un proceso hijo en background..."
    ( sleep 5; fireworks; echo "[MINDBLOW] Proceso hijo finalizado con fuegos artificiales." ) &
    echo "[MINDBLOW] Proceso hijo lanzado. PID del hijo: $!"
    return 0
}

########################################
# Conversión de imagen a ASCII con ultra alta resolución reducida
########################################
img_to_ascii() {
    if [ -z "$1" ]; then
        echo "[IMG2ASCII] Por favor, especifica el archivo de imagen a convertir."
        return 1
    fi
    local image_file="$1"
    if [ ! -f "$image_file" ]; then
        echo "[IMG2ASCII] El archivo '$image_file' no existe."
        return 1
    fi
    if command -v img2txt >/dev/null 2>&1; then
        img2txt --width=240 "$image_file"
    elif command -v jp2a >/dev/null 2>&1; then
        jp2a --width=240 "$image_file"
    else
        echo "[IMG2ASCII] No se encontró herramienta de conversión (se requiere libcaca con img2txt)."
        return 1
    fi
    return 0
}

########################################
# Nuevas funcionalidades: typewriter, fractales, clima, minigame2, tts
########################################
# Efecto máquina de escribir
typewriter() {
    local text="$*"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "\033[1;32m${text:$i:1}\033[0m"
        sleep 0.05
    done
    echo ""
}

# Generador de fractales (Mandelbrot) en ASCII
fractales() {
    awk 'BEGIN {
        max_iter = 50;
        for (i = 0; i < 40; i++) {
            for (j = 0; j < 80; j++) {
                x0 = (j - 40.0) / 20.0;
                y0 = (i - 20.0) / 20.0;
                x = 0; y = 0;
                iter = 0;
                while (x*x + y*y <= 4 && iter < max_iter) {
                    xtemp = x*x - y*y + x0;
                    y = 2*x*y + y0;
                    x = xtemp;
                    iter++;
                }
                if (iter == max_iter) {
                    printf "\033[1;37m#\033[0m"; # Blanco para el conjunto
                } else if (iter > 40) {
                    printf "\033[1;31m.\033[0m"; # Rojo
                } else if (iter > 30) {
                    printf "\033[1;33m.\033[0m"; # Amarillo
                } else if (iter > 20) {
                    printf "\033[1;32m.\033[0m"; # Verde
                } else if (iter > 10) {
                    printf "\033[1;34m.\033[0m"; # Azul
                } else {
                    printf "\033[1;35m.\033[0m"; # Magenta
                }
            }
            printf "\n";
        }
    }'
}

# Visualización del clima con más datos en formato tabla y colores
clima() {
    if command -v curl >/dev/null 2>&1; then
        output=$(curl -s 'wttr.in/?format=%l,%C,%t,%w,%h,%p')
        IFS=',' read -r location condition temperature wind humidity precipitation <<< "$output"
        
        echo -e "\033[1;34mUbicación:\033[0m $location"
        echo -e "\033[1;32mCondición:\033[0m $condition"
        echo -e "\033[1;33mTemperatura:\033[0m $temperature"
        echo -e "\033[1;36mViento:\033[0m $wind"
        echo -e "\033[1;35mHumedad:\033[0m $humidity"
        echo -e "\033[1;31mPrecipitación:\033[0m $precipitation"
        echo
    else
        echo -e "\033[1;31mClima: Desconocido (curl no está disponible)\033[0m"
    fi
}

# Minigame2: Space Invaders (usa el juego 'ninvaders' instalado vía Brew)
minigame2() {
    if command -v ninvaders >/dev/null 2>&1; then
         ninvaders
    else
         echo "El juego Space Invaders no está instalado. Instálalo con: brew install ninvaders"
    fi
}

# Text-to-Speech (TTS) manual
tts() {
    text_to_speech "$@"
}

########################################
# Procesamiento de comandos
########################################
process_command() {
    local cmd="$1"
    shift
    local ret=0
    case "$cmd" in
        alias)
            alias_command "$@"; ret=$?
            ;;
        install)
            install_app "$@"; ret=$?
            ;;
        uninstall)
            uninstall_app "$@"; ret=$?
            ;;
        mini-game-1)
            mini_game_1 "$@"; ret=$?
            ;;
        help)
            show_help "$@"; ret=$?
            ;;
        about)
            show_about "$@"; ret=$?
            ;;
        fecha)
            show_date "$@"; ret=$?
            ;;
        dibujito)
            show_dibujito "$@"; ret=$?
            ;;
        kill-process)
            kill_process "$@"; ret=$?
            ;;
        pid)
            show_pid "$@"; ret=$?
            ;;
        mindblow)
            mindblow "$@"; ret=$?
            ;;
        img2ascii)
            img_to_ascii "$@"; ret=$?
            ;;
        typewriter)
            typewriter "$@"; ret=$?
            ;;
        fractales)
            fractales; ret=$?
            ;;
        clima)
            clima; ret=$?
            ;;
        minigame2)
            minigame2; ret=$?
            ;;
        tts)
            tts "$@"; ret=$?
            ;;
        emergencia)
            emergencia; ret=$?
            ;;
        exit)
            exit_show
            ;;
        *)
            "$cmd" "$@"
            ret=$?
            ;;
    esac
    if [ $ret -eq 0 ]; then
        play_success_sound
    else
        play_error_sound
    fi
}

########################################
# Inicio de la ejecución
########################################
# Preguntar al inicio si se desea habilitar el TTS automático
read -p "¿Deseas habilitar el Text-to-Speech automático? (si/no): " tts_answer
if [[ "$tts_answer" =~ ^[sS] ]]; then
    TTS_AUTO=1
    text_to_speech "Text to Speech activado."
else
    TTS_AUTO=0
fi

# Mostrar animación de welcome (banner con el loro)
welcome_banner

# Si se pasan argumentos, procesarlos y salir
if [ $# -gt 0 ]; then
    process_command "$@"
    exit 0
fi

# Bucle interactivo: prompt sin colores
while true; do
    prompt="$(whoami)@miordenador > "
    read -p "$prompt" user_input
    [ -z "$user_input" ] && continue
    cmd=$(echo "$user_input" | awk '{print $1}')
    args=$(echo "$user_input" | cut -d' ' -f2-)
    process_command "$cmd" $args
done
