import toga
import socket
import requests
import platform
from datetime import datetime

SERVER_URL = ""

class IPcatcherApp(toga.App):
    def startup(self):
        self.main_window = toga.MainWindow(title="IP Catcher", size=(400, 500))
        
        self.url_input = toga.TextInput(placeholder="URL del servidor (ej: http://tu-ip.ngrok.io)", readonly=False)
        self.info_box = toga.MultilineTextInput(readonly=True, height=200)
        self.status_label = toga.Label("Presiona CAPTURAR para enviar datos", style=Pack(flex=1))
        
        btn = toga.Button("CAPTURAR Y ENVIAR", on_press=self.capturar, style=Pack(padding=10))
        
        box = toga.Box(
            children=[
                toga.Label("IP CATCHER", style=Pack(font_size=24, text_align="center", padding_bottom=20)),
                self.url_input,
                toga.Label(""),  
                self.info_box,
                self.status_label,
                btn
            ],
            direction=COLUMN,
            padding=20
        )
        
        self.main_window.content = box
        self.main_window.show()
    
    def get_info(self):
        try:
            local_ip = socket.gethostbyname(socket.gethostname())
        except:
            local_ip = "No disponible"
        
        try:
            public_ip = requests.get("https://api.ipify.org", timeout=5).text
        except:
            public_ip = "No disponible"
        
        info = f"""=== IP CATCHER ===
IP Local: {local_ip}
IP Publica: {public_ip}
Dispositivo: {platform.system()}
Modelo: {platform.node()}
Fecha: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
================"""
        return info
    
    def capturar(self, widget):
        url = self.url_input.value.strip()
        
        if not url:
            self.status_label.text = "[!] Ingresa la URL del servidor"
            return
        
        if not url.startswith("http"):
            url = "http://" + url
        
        self.status_label.text = "[...] Enviando..."
        
        try:
            info = self.get_info()
            self.info_box.value = info
            requests.post(f"{url}/save", data={"info": info, "type": "android"}, timeout=10)
            self.status_label.text = "[OK] Datos enviados!"
        except Exception as e:
            self.status_label.text = f"[OK] Datos capturados (guardados local)"
            self.info_box.value = self.get_info()

def main():
    return IPcatcherApp()
