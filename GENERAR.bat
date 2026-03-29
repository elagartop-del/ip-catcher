@echo off
chcp 65001 >nul
title IP Catcher Generator

echo.
echo  ██████╗  ██████╗ ██████╗     ██╗     ██╗███████╗███████╗
echo  ██╔══██╗██╔═══██╗██╔══██╗    ██║     ██║╚════██║╚════██║
echo  ██████╔╝██║   ██║██████╔╝    ██║     ██║    ██╔╝    ██╔╝
echo  ██╔══██╗██║   ██║██╔══██╗    ██║     ██║   ██╔╝     ██║
echo  ██║  ██║╚██████╔╝██████╔╝    ███████╗██║   ██║      ██║
echo  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚══════╝╚═╝   ╚═╝      ╚═╝
echo.
echo  ==================== GENERADOR ====================
echo.

echo [1/3] Instalando dependencias...
pip install pyinstaller flask requests -q 2>nul

echo [2/3] Generando EXE para Windows...
pyinstaller --onefile --noconsole ip_catcher.py -q 2>nul
if exist "dist\IP_Catcher.exe" (
    copy "dist\IP_Catcher.exe" "IP_Catcher.exe" >nul
    rmdir /s /q dist 2>nul
    rmdir /s /q build 2>nul
    rmdir /s /q __pycache__ 2>nul
    del /q ip_catcher.spec 2>nul
    echo         [OK] IP_Catcher.exe
) else (
    echo         [ERROR] No se generó el EXE
)

echo.
echo [3/3] APK para Android
echo.
echo  Para crear el APK necesitas:
echo  1. Instalar Python en tu Android (Termux):
echo     pkg install python
echo.
echo  2. Instalar Kivy:
echo     pip install kivy
echo.
echo  3. Copiar android_catcher.py a tu Android
echo.
echo  4. Ejecutar:
echo     python android_catcher.py buildozer android
echo.
echo  O usa la app Kivy Launcher desde Google Play.
echo.

echo.
echo  ==================== LISTO ====================
echo.
echo  Archivos generados:
echo    - IP_Catcher.exe (Windows)
echo.
echo  Próximos pasos:
echo    1. python server.py
echo    2. Abrir http://127.0.0.1:5000
echo    3. Ejecutar IP_Catcher.exe
echo.
echo  ==================== ====================
echo.
pause
