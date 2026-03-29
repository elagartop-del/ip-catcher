# IP Logger Local

## Archivos creados:
- `ip_catcher.py` - Script que captura IPs y las envía al servidor
- `server.py` - Servidor local Flask que recibe y guarda los datos
- `index.html` - Interfaz web para ver los logs
- `build_exe.py` - Generador del ejecutable

## Uso:

### 1. Generar el EXE:
```bash
pip install pyinstaller requests
python build_exe.py
```

### 2. Iniciar el servidor:
```bash
pip install flask requests
python server.py
```

### 3. Ejecutar IP_Catcher.exe en la víctima
Los datos se guardarán en `logs.txt` y se mostrarán en `http://127.0.0.1:8080`

## Requisitos:
- Python 3.x
- Flask
- Requests
- PyInstaller (solo para generar el exe)
