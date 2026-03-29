import PyInstaller.__main__
import os

print("=" * 50)
print("  GENERANDO EXE...")
print("=" * 50)

PyInstaller.__main__.run([
    "ip_catcher.py",
    "--onefile",
    "--noconsole",
    "--name", "IP_Catcher",
    "--distpath", ".",
    "--workpath", "build",
    "--clean"
])

if os.path.exists("IP_Catcher.exe"):
    print("\n✓ EXE generado exitosamente: IP_Catcher.exe")
else:
    print("\n✗ Error al generar el EXE")
