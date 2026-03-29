from kivy.app import App
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout
import socket
import requests
import platform
import json
from datetime import datetime

class IPcatcherApp(App):
    def build(self):
        self.title = "IP Catcher"
        layout = BoxLayout(orientation='vertical', padding=20, spacing=10)
        
        self.status = Label(text="[+] IP Catcher [+]", font_size=20, size_hint_y=None, height=50)
        layout.add_widget(self.status)
        
        self.url_input = TextInput(hint_text="URL del servidor (ej: http://xxx.ngrok.io)", multiline=False, size_hint_y=None, height=50)
        layout.add_widget(self.url_input)
        
        self.info_label = Label(text="", font_size=12)
        layout.add_widget(self.info_label)
        
        btn = Button(text="CAPTURAR Y ENVIAR", size_hint_y=None, height=60)
        btn.bind(on_press=self.send_data)
        layout.add_widget(btn)
        
        return layout
    
    def get_info(self):
        try:
            local_ip = socket.gethostbyname(socket.gethostname())
        except:
            local_ip = "No disponible"
        
        try:
            public_ip = requests.get("https://api.ipify.org", timeout=5).text
        except:
            public_ip = "No disponible"
        
        info = []
        info.append("=== CAPTURA ANDROID ===")
        info.append(f"IP Local: {local_ip}")
        info.append(f"IP Publica: {public_ip}")
        info.append(f"Dispositivo: {platform.system()}")
        info.append(f"Modelo: {platform.node()}")
        info.append(f"Marca: {platform.platform()}")
        info.append(f"Fecha: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        try:
            info.append(f"Hostname: {socket.gethostname()}")
        except:
            pass
        info.append("=" * 25)
        return "\n".join(info)
    
    def send_data(self, instance):
        server_url = self.url_input.text.strip()
        
        if not server_url:
            self.status.text = "[!] Ingresa la URL del servidor"
            return
        
        if not server_url.startswith("http"):
            server_url = "http://" + server_url
        
        self.status.text = "[...] Enviando datos..."
        self.info_label.text = ""
        
        try:
            info = self.get_info()
            response = requests.post(f"{server_url}/save", data={"info": info, "type": "android"}, timeout=10)
            
            self.status.text = "[OK] Datos enviados!"
            self.info_label.text = info
            
        except requests.exceptions.ConnectionError:
            self.status.text = "[ERROR] No se pudo conectar"
            self.info_label.text = "Verifica la URL del servidor\nAsegurate que el servidor este activo"
        except Exception as e:
            self.status.text = f"[ERROR] {str(e)[:30]}"
            self.info_label.text = ""

if __name__ == '__main__':
    IPcatcherApp().run()
