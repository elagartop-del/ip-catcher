@echo off
chcp 65001 >nul
title IP Catcher APK Builder

echo.
echo  ========================================
echo   INSTALANDO HERRAMIENTAS...
echo  ========================================
echo.

REM Verificar Python
python --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python no instalado
    echo Descarga de: python.org
    pause
    exit
)
echo [OK] Python encontrado

REM Instalar Chocolatey
where choco >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo.
    echo Instalando Chocolatey...
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" >nul 2>&1
    set PATH=%PATH%;C:\ProgramData\chocolatey\bin
)

REM Instalar Git y make
echo.
echo [1/5] Instalando Git y make...
choco install git make -y >nul 2>&1

REM Instalar Java
echo [2/5] Instalando Java...
choco install openjdk17 -y >nul 2>&1

REM Instalar Python packages
echo [3/5] Instalando Python packages...
pip install kivy buildozer requests --quiet

REM Descargar Android SDK
echo [4/5] Descargando Android SDK...
if not exist "android-sdk" (
    curl -L -o cmdline-tools.zip "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip"
    mkdir android-sdk
    tar -xf cmdline-tools.zip -C android-sdk
    move android-sdk\cmdline-tools android-sdk\cmdline-tools-temp
    mkdir android-sdk\cmdline-tools
    move android-sdk\cmdline-tools-temp android-sdk\cmdline-tools\latest
    del cmdline-tools.zip
)

set ANDROIDSDK=%CD%\android-sdk
set PATH=%PATH%;%ANDROIDSDK%\cmdline-tools\latest\bin;%ANDROIDSDK%\platform-tools

REM Aceptar licencias e instalar componentes
echo [5/5] Configurando SDK...
echo y | sdkmanager --licenses >nul 2>&1
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" >nul 2>&1

echo.
echo  ========================================
echo   INSTALACION COMPLETA!
echo  ========================================
echo.
echo   Ahora ejecuta:
echo   buildozer android debug
echo.
echo   El APK saldra en: bin\ipcatcher-1.0-armeabi-v7a-debug.apk
echo.
pause
