@echo off
chcp 65001 >nul
title IP Catcher - Build APK (WSL)

echo.
echo  ========================================
echo   CONSTRUYENDO APK EN WSL
echo  ========================================
echo.

REM Verificar WSL
wsl --status >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo WSL no instalado. Instalando...
    wsl --install
    echo.
    echo REINICIA tu PC y vuelve a ejecutar este script
    pause
    exit
)

REM Verificar Ubuntu en WSL
wsl -l | findstr Ubuntu >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo Instala Ubuntu desde Microsoft Store
    echo Luego vuelve a ejecutar
    pause
    exit
)

echo [1/6] Actualizando Ubuntu...
wsl --distribution Ubuntu --user root -- bash -c "apt update -qq" 2>nul

echo [2/6] Instalando Python y Java...
wsl --distribution Ubuntu --user root -- bash -c "apt install -y python3 python3-pip openjdk-17-jdk-headless git wget unzip -qq" 2>nul

echo [3/6] Instalando Kivy y Buildozer...
wsl --distribution Ubuntu --user root -- bash -c "pip3 install kivy buildozer requests -q" 2>nul

echo [4/6] Descargando Android SDK...
wsl --distribution Ubuntu --user root -- bash -c "cd /tmp && wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdline-tools.zip && unzip -q cmdline-tools.zip && mkdir -p ~/android-sdk/cmdline-tools && mv cmdline-tools ~/android-sdk/cmdline-tools/latest" 2>nul

echo [5/6] Configurando SDK...
wsl --distribution Ubuntu --user root -- bash -c "export ANDROIDSDK=~/android-sdk && export PATH=\$PATH:\$ANDROIDSDK/cmdline-tools/latest/bin && yes | sdkmanager --licenses >nul 2>&1 && sdkmanager 'platform-tools' 'platforms;android-34' 'build-tools;34.0.0' -q" 2>nul

echo [6/6] Compilando APK...
echo    (Esto tardara 10-20 minutos)

REM Copiar archivos
wsl --distribution Ubuntu --user root -- bash -c "cp -r /mnt/c/Users/sopic/Downloads/bloxono\\ tool/app /tmp/IPCatcher 2>/dev/null || mkdir -p /tmp/IPCatcher"
wsl --distribution Ubuntu --user root -- bash -c "cp /mnt/c/Users/sopic/Downloads/bloxono\\ tool/buildozer.spec /tmp/IPCatcher/"
wsl --distribution Ubuntu --user root -- bash -c "cp /mnt/c/Users/sopic/Downloads/bloxono\\ tool/android_catcher.py /tmp/IPCatcher/main.py"

REM Cambiar directorio de trabajo
wsl --distribution Ubuntu --user root -- bash -c "cd /tmp/IPCatcher && export ANDROIDSDK=~/android-sdk && export PATH=\$PATH:\$ANDROIDSDK/cmdline-tools/latest/bin:\$ANDROIDSDK/platform-tools && buildozer android debug 2>&1"

echo.
echo  ========================================
echo   COMPILACION COMPLETA
echo  ========================================
echo.
echo   Buscando APK...

if exist "C:\Users\sopic\Downloads\bloxono tool\bin\*.apk" (
    echo [OK] APK encontrado!
    dir "C:\Users\sopic\Downloads\bloxono tool\bin\*.apk"
) else (
    echo El APK puede estar en la carpeta bin/
    echo dentro de WSL en: /tmp/IPCatcher/bin/
)

echo.
pause
