@echo off
cd ipcatcher

REM Aceptar licencia Java
mkdir "%USERPROFILE%\.jdk" 2>nul
echo license=License is accepted. > "%USERPROFILE%\.jdk\.accepted"

REM Intentar crear (las licencias de Android SDK se aceptan interactivamente)
python -m briefcase create android <<EOF
y
y
y
y
y
y
y
y
y
y
y
y
y
y
EOF
