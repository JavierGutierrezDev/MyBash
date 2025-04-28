from flask import Flask, request, jsonify, render_template
import subprocess, os
from werkzeug.utils import secure_filename
from subprocess import check_output, CalledProcessError, run, DEVNULL, STDOUT
from flask import send_from_directory
import time
import os


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/run', methods=['POST'])
def run_cmd():
    data = request.get_json()
    cmd  = data.get('comando')
    args = data.get('args', [])

    # Ramas especiales que no devuelven texto
    if cmd == 'make_call':
        # Lanzamos la llamada sin capturar output
        run(
            ['bash', './mibash.sh', 'call'] + args,
            stdout=DEVNULL, stderr=DEVNULL, check=True
        )
        return jsonify({'output': f'Llamando a {args[0]}…'})



    try:
        out = subprocess.check_output(
            ['bash', './mibash.sh', cmd] + args,
            stderr=subprocess.STDOUT,
            text=True
        )
        return jsonify({'output': out})
    except subprocess.CalledProcessError as e:
        return jsonify({'output': e.output, 'error': True})

@app.route('/ascii', methods=['POST'])
def ascii_cmd():
    f  = request.files['image']
    fn = secure_filename(f.filename)
    path = os.path.join(app.config['UPLOAD_FOLDER'], fn)
    f.save(path)

    try:
        # 1) Obtén el output ANSI
        out = subprocess.check_output(
            ['bash', './mibash.sh', 'img_to_ascii', path],
            stderr=subprocess.STDOUT,
            text=True
        )

        # 2) Guarda en asciiArt/<nombre_timestamp>.txt
        ascii_dir = 'asciiArt'
        os.makedirs(ascii_dir, exist_ok=True)
        base = os.path.splitext(fn)[0]
        timestamp = int(time.time())
        save_name = f"{base}_{timestamp}.txt"
        save_path = os.path.join(ascii_dir, save_name)
        with open(save_path, 'w') as af:
            af.write(out)

        # 3) Devuelve ANSI + nombre de fichero
        return jsonify({
            'output': out,
            'file': save_name
        })

    except subprocess.CalledProcessError as e:
        return jsonify({'output': e.output, 'error': True})
    finally:
        os.remove(path)

# 4) Nueva ruta para servir los ficheros guardados
@app.route('/asciiArt/<filename>')
def serve_ascii(filename):
    return send_from_directory('asciiArt', filename, mimetype='text/plain')


# Nueva ruta para el juego de Adivinar Número
@app.route('/game/guess')
def game_guess():
    return render_template('guess.html')


@app.route('/showAbout')
def show_about():
    return render_template('aboutUs.html')

if __name__ == '__main__':
    app.run(debug=True)
