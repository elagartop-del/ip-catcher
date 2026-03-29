@echo off
chcp 65001 >nul
title IP Catcher - Generador APK

echo.
echo  ========================================
echo   GENERANDO APK...
echo  ========================================
echo.

cd ipcatcher

echo [1/3] Instalando dependencias...
pip install briefcase toga-android requests -q

echo [2/3] Aceptando licencias de Android SDK...
REM Crear archivo de licencias aceptadas
mkdir "%USERPROFILE%\.android" 2>nul
echo -89365618 > "%USERPROFILE%\.android\repositories.cfg"
echo y > accept.txt
(
    echo y
    echo y
    echo y
    echo y
    echo y
    echo y
    echo y
) > accept_all.txt

echo [3/3] Generando APK...
echo    (Tardara 10-30 minutos)
echo.

REM Intentar con accept all
type accept_all.txt | python -m briefcase create android
type accept_all.txt | python -m briefcase build android

cd ..

echo.
echo  ========================================
echo   REVISANDO RESULTADO...
echo  ========================================
echo.

if exist "ipcatcher\build\android\**\*.apk" (
    for /r "ipcatcher\build\android" %%f in (*.apk) do (
        echo [OK] APK encontrado!
        copy "%%f" "IP_Catcher.apk" >nul
    )
) else (
    echo El APK puede estar en:
    echo ipcatcher\build\android\
    echo.
    echo Buscando...
    dir /s /b "ipcatcher\build\android\*.apk" 2>nul
)

if exist "IP_Catcher.apk" (
    echo.
    echo  ========================================
    echo   [OK] APK GENERADO: IP_Catcher.apk
    echo  ========================================
)

pause
