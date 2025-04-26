from flask import Flask, request, jsonify, render_template
import subprocess, os
from werkzeug.utils import secure_filename

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
    f = request.files['image']
    fn = secure_filename(f.filename)
    path = os.path.join(app.config['UPLOAD_FOLDER'], fn)
    f.save(path)
    try:
        out = subprocess.check_output(
            ['bash', './mibash.sh', 'img_to_ascii', path],
            stderr=subprocess.STDOUT,
            text=True
        )
        return jsonify({'output': out})
    except subprocess.CalledProcessError as e:
        return jsonify({'output': e.output, 'error': True})
    finally:
        os.remove(path)

# Nueva ruta para el juego de Adivinar Número
@app.route('/game/guess')
def game_guess():
    return render_template('guess.html')


@app.route('/showAbout')
def show_about():
    return render_template('aboutUs.html')

if __name__ == '__main__':
    app.run(debug=True)
