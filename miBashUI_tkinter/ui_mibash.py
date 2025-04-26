
import tkinter as tk
from tkinter import scrolledtext
import subprocess
import threading

# Ruta al script bash
SCRIPT_PATH = "./mibash.sh"

# Función para ejecutar comandos del script
def ejecutar_funcion(comando):
    def run():
        consola.delete("1.0", tk.END)
        try:
            process = subprocess.Popen(
                ["/bin/bash", SCRIPT_PATH, comando],
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True
            )
            for line in process.stdout:
                consola.insert(tk.END, line)
                consola.see(tk.END)
            process.wait()
        except Exception as e:
            consola.insert(tk.END, f"Error: {e}\n")

    threading.Thread(target=run).start()

# Crear ventana principal
ventana = tk.Tk()
ventana.title("Mi Shell Interactiva")
ventana.geometry("700x500")

# Crear botones
botones = {
    "Instalar/Desinstalar": "instalar",
    "Convertir a ASCII": "ascii",
    "Efectos Visuales": "efectos",
    "Minijuegos": "juegos",
    "Text-to-Speech": "tts",
    "Espectáculo": "show"
}

for texto, comando in botones.items():
    tk.Button(
        ventana,
        text=texto,
        width=20,
        command=lambda cmd=comando: ejecutar_funcion(cmd)
    ).pack(pady=5)

# Crear consola de salida
consola = scrolledtext.ScrolledText(ventana, width=80, height=20)
consola.pack(padx=10, pady=10)

ventana.mainloop()
