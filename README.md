# 🚀 Mi Shell Interactiva (Web)

---

## 🔧 Tecnologías utilizadas

- 🐚 **Bash Script** (`mibash.sh`): funciones para gestión de paquetes, procesos, ASCII art, llamadas y más.  
- 🐍 **Python & Flask** (`app.py`): servidor web con endpoints `/run`, `/ascii`, `/asciiArt/<file>` y `/game/guess`.  
- 🌐 **HTML5 & CSS3**: plantillas en `templates/` (`index.html`, `guess.html`, `about.html`).  
- 🎨 **Bootstrap 5**: diseño responsive y componentes listos para usar.  
- 🔣 **Bootstrap Icons**: iconos vectoriales modernos.  
- 🌈 **ANSI Up**: convierte secuencias ANSI (colores de terminal) a HTML coloreado.

---

## 📖 Descripción del proyecto

Mi Shell Interactiva (Web) es una **interfaz gráfica** sobre herramientas en Bash, que permite:

- ⚙️ Ejecutar comandos comunes de Linux (instalación, alias, procesos).  
- 📅 Mostrar fecha y hora del sistema.  
- ☁️ Consultar el clima de cualquier ciudad.  
- 🖼️ Convertir imágenes a **arte ASCII** con colores en pantalla y archivo guardado.  
- 📞 Realizar llamadas desde la web (protocolo `tel:`).  
- 🎯 Jugar a “Adivina el número” en el navegador.  
- 👾 Lanzar Space Invaders en terminal vía modal informativo.

---

## Clonar el repositorio 
git clone https://github.com/usuario/mi-shell-web.git
cd mi-shell-web



## Crear entorno virtual e instalar dependencias 
python3 -m venv venv
source venv/bin/activate
pip install Flask werkzeug


## Permisos de ejecución
chmod +x mibash.sh


## Iniciar servidor 
python app.py




