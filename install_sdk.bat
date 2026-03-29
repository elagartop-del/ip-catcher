@echo off
chcp 65001 >nul
set ANDROIDSDK=C:\Android
set PATH=%PATH%;C:\Android\cmdline-tools\latest\bin

echo Aceptando licencias...
echo y | sdkmanager --licenses >nul 2>&1

echo Instalando platform-tools y build-tools...
call sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0" "ndk;25.2.9519653"

echo.
echo SDK Instalado!
echo.
echo Ahora ejecuta: buildozer android debug
pause
