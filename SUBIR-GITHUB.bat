@echo off
chcp 65001 >nul
title Subir a GitHub

echo.
echo  ========================================
echo   SUBIENDO A GITHUB
echo  ========================================
echo.

REM Inicializar git
git init 2>nul
git add .
git commit -m "IP Catcher"

echo.
echo  ========================================
echo   PASOS:
echo  ========================================
echo.
echo   1. Ve a: https://github.com/new
echo.
echo   2. Crea un repositorio llamado: IP-Catcher
echo      (sin inicializar con README)
echo.
echo   3. Aqui estan los comandos, copialos y pegalos
echo      en otra terminal de Git Bash (clic derecho > Git Bash Here):
echo.
echo  ========================================
echo.

echo Copia estos comandos:
echo.
echo   git remote add origin https://github.com/TU_USUARIO/IP-Catcher.git
echo   git branch -M master
echo   git push -u origin master
echo.
echo  ========================================
echo.
echo   4. Despues ve a:
echo      https://github.com/TU_USUARIO/IP-Catcher/actions
echo.
echo   5. Click "I understand my workflows" si aparece
echo.
echo   6. Click en "Build APK" en la lista
echo.
echo   7. Click "Run workflow" > "Run workflow"
echo.
echo   8. Espera 5-10 minutos
echo.
echo   9. Click en el trabajo (job) > Artifacts > IP_Catcher_APK
echo.
echo  ========================================
echo.
echo  TEN EN CUENTA:
echo  - Cambia TU_USUARIO por tu usuario de GitHub
echo  - Crea cuenta en github.com si no tienes
echo.
pause
