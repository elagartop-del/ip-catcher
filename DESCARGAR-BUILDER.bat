@echo off
title IP Catcher - Build APK

echo.
echo  ========================================
echo   DESCARGANDO HERRAMIENTAS...
echo  ========================================
echo.

REM Crear carpeta
mkdir "C:\APK_Builder" 2>nul
cd "C:\APK_Builder"

REM Descargar APK Editor Studio (similar a Android Studio pero ligero)
echo Descargando APK Editor Studio...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/nicholasnguyen/Android-Kivy-Builder/releases/download/v1.0/Android-Kivy-Builder.exe' -OutFile 'Builder.exe'" 2>nul

echo.
echo  ========================================
echo   LISTO!
echo  ========================================
echo.
echo   Ejecuta: Builder.exe
echo.
echo   O usa la opcion 2: WSL
echo.
pause
