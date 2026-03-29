@echo off
chcp 65001 >nul
title IP Catcher - Todo en Uno

echo.
echo  ╔════════════════════════════════════════╗
echo  ║     IP CATCHER - TODO EN UNO          ║
echo  ╚════════════════════════════════════════╝
echo.

REM Instalar dependencias
echo [1/5] Verificando dependencias...
pip install flask requests pyngrok -q 2>nul
echo         [OK] Dependencias instaladas

REM Verificar ngrok
where ngrok >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [2/5] Instalando ngrok...
    echo         Descarga ngrok de: https://ngrok.com/download
    echo         Y extraelo en esta carpeta
    echo.
)

REM Iniciar servidor en segundo plano
echo [3/5] Iniciando servidor...
start "SERVER" python server.py
timeout /t 3 /nobreak >nul

REM Verificar si ngrok existe
if exist "ngrok.exe" (
    echo [4/5] Iniciando ngrok tunnel...
    start "NGROK" ngrok http 5000
    timeout /t 5 /nobreak >nul
    
    REM Obtener URL de ngrok (necesita API key)
    echo.
    echo  ================================================
    echo   IMPORTANTE:
    echo  ================================================
    echo.
    echo   1. Si ngrok abre una ventana, copia la URL
    echo      (ejemplo: https://abc123.ngrok.io)
    echo.
    echo   2. En el APK de Android, ingresa esa URL
    echo.
    echo  ================================================
) else (
    echo [4/5] Ngrok no encontrado
    echo.
    echo   ===========================================
    echo    PARA CONECTAR DESDE ANDROID:
    echo   ===========================================
    echo.
    echo   Opcion 1 - Ngrok (recomendado):
    echo   1. Descarga ngrok.exe de ngrok.com
    echo   2. Crea cuenta gratis en ngrok.com
    echo   3. Copia tu Authtoken
    echo   4. Ejecuta: ngrok config add-authtoken TU_TOKEN
    echo   5. Ejecuta este script de nuevo
    echo.
    echo   Opcion 2 - Sin ngrok:
    echo   - Solo funciona si abres puerto 5000 en tu router
    echo.
    echo  ===========================================
)

echo [5/5] Servidor activo en http://127.0.0.1:5000
echo.
echo  ================================================
echo   LISTO!
echo  ================================================
echo.
echo   Para ver IPs capturadas:
echo   - Abre: http://127.0.0.1:5000
echo.
echo   Archivos generados:
echo   - IP_Catcher.exe (Windows)
echo   - IP_Catcher.apk (Android, generar con GitHub Actions)
echo   - logs.txt (registros guardados)
echo.
echo  ================================================
echo.
echo  Presiona cualquier tecla para salir...
pause >nul
