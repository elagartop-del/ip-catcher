@echo off
chcp 65001 >nul
title APK Generator - IP Catcher

echo.
echo  ██████╗  ██████╗ ██████╗      ██╗    ██╗██╗███╗   ██╗
echo  ██╔══██╗██╔═══██╗██╔══██╗    ██║    ██║██║████╗  ██║
echo  ██████╔╝██║   ██║██████╔╝    ██║ █╗ ██║██║██╔██╗ ██║
echo  ██╔══██╗██║   ██║██╔══██╗    ██║███╗██║██║██║╚██╗██║
echo  ██║  ██║╚██████╔╝██████╔╝    ╚███╔███╔╝██║██║ ╚████║
echo  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝      ╚══╝╚══╝ ╚═╝╚═╝  ╚═══╝
echo.
echo  ==================== GENERADOR APK ====================
echo.

REM Descargar SDK si no existe
if not exist "C:\Android\cmdline-tools\latest\bin\sdkmanager.bat" (
    echo [1/4] Descargando Android SDK...
    curl -L -o "cmdline-tools.zip" "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip" 2>nul
    mkdir "C:\Android\cmdline-tools" 2>nul
    tar -xf "cmdline-tools.zip" -C "C:\Android\cmdline-tools"
    move "C:\Android\cmdline-tools\cmdline-tools" "C:\Android\cmdline-tools\latest" >nul 2>&1
    del "cmdline-tools.zip"
    echo         [OK] SDK descargado
) else (
    echo [1/4] SDK ya instalado
)

set ANDROIDSDK=C:\Android
set PATH=%PATH%;C:\Android\cmdline-tools\latest\bin;C:\Android\platform-tools

REM Aceptar licencias
echo [2/4] Aceptando licencias...
echo y | sdkmanager --licenses >nul 2>&1

REM Instalar componentes
echo [3/4] Instalando componentes SDK...
call sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "ndk;25.2.9519653" >nul 2>&1
echo         [OK] Componentes instalados

REM Generar APK
echo [4/4] Generando APK...
buildozer android debug 2>&1

if exist "bin\ipcatcher-1.0-arm64-v8a_armeabi-v7a-debug.apk" (
    copy "bin\ipcatcher-1.0-arm64-v8a_armeabi-v7a-debug.apk" "IP_Catcher.apk" >nul
    echo.
    echo  ========================================
    echo   [OK] APK GENERADO: IP_Catcher.apk
    echo  ========================================
    echo.
    echo  Instala el APK en tu Android y ejecutalo.
    echo  Los datos llegaran a tu servidor local.
) else (
    echo.
    echo  [ERROR] No se genero el APK
    echo  Revisa los errores arriba.
)

echo.
pause
