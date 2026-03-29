@echo off
chcp 65001 >nul
title IP Catcher - Generador APK

echo.
echo  ========================================
echo   GENERANDO APK...
echo  ========================================
echo.

cd ipcatcher

REM Instalar dependencias
echo [1/4] Instalando dependencias...
pip install briefcase toga-android requests -q 2>nul
echo         [OK]

REM Crear proyecto Android
echo [2/4] Creando proyecto Android...
python -m briefcase create android -Q 2>nul
echo         [OK]

REM Construir APK
echo [3/4] Construyendo APK...
echo    (Esto tardara 10-20 minutos)
python -m briefcase build android -Q

echo [4/4] Copiando APK...
if exist "build\android\gradle\app\build\outputs\apk\debug\*.apk" (
    copy "build\android\gradle\app\build\outputs\apk\debug\*.apk" "..\IP_Catcher.apk"
    echo         [OK]
) else (
    echo         Buscando APK...
    for /r "build\android" %%f in (*.apk) do (
        copy "%%f" "..\IP_Catcher.apk"
    )
)

cd ..

echo.
echo  ========================================
if exist "IP_Catcher.apk" (
    echo   [OK] APK GENERADO: IP_Catcher.apk
) else (
    echo   [INFO] El APK puede estar en:
    echo   ipcatcher\build\android\
)
echo  ========================================
echo.
pause
