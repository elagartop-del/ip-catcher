from flask import Flask, request, render_template_string, jsonify
from datetime import datetime
import os

app = Flask(__name__)

LOGS_FILE = "logs.txt"
logs = []

def load_logs():
    global logs
    if os.path.exists(LOGS_FILE):
        with open(LOGS_FILE, "r", encoding="utf-8") as f:
            content = f.read()
            if content.strip():
                entries = content.split("\n---REGISTRO---\n")[:-1]
                logs = []
                for e in entries:
                    lines = e.strip().split('\n', 1)
                    if len(lines) > 1:
                        logs.append({"info": lines[1].strip(), "timestamp": lines[0].strip()})
                    else:
                        logs.append({"info": e.strip(), "timestamp": ""})

def save_to_file(info):
    with open(LOGS_FILE, "a", encoding="utf-8") as f:
        f.write(f"{info}\n---REGISTRO---\n")

@app.route("/")
def index():
    return render_template_string(open("index.html", "r", encoding="utf-8").read())

@app.route("/save", methods=["POST"])
def save():
    info = request.form.get("info", "")
    data_type = request.form.get("type", "unknown")
    if info:
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        save_to_file(f"{timestamp}\n[{data_type.upper()}]\n{info}")
        logs.append({"info": info, "timestamp": timestamp, "type": data_type})
    return "OK"

@app.route("/logs")
def get_logs():
    load_logs()
    return jsonify(logs[::-1])

@app.route("/clear", methods=["POST"])
def clear():
    global logs
    logs = []
    if os.path.exists(LOGS_FILE):
        os.remove(LOGS_FILE)
    return "OK"

if __name__ == "__main__":
    print("=" * 50)
    print("  SERVIDOR IP LOGGER - LOCALHOST:5000")
    print("=" * 50)
    print(f"  Logs guardados en: {LOGS_FILE}")
    print("=" * 50)
    app.run(host="127.0.0.1", port=5000, debug=False)
