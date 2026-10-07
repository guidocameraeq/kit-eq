"""empaquetar.py — arma un ZIP por skill en dist/ para subirlas a Cowork / Chat.

En cuentas Pro las skills se suben de a una como ZIP (Configuración > Skills).
Cada ZIP lleva la carpeta de la skill entera (SKILL.md + plantillas/scripts).

Uso:  py herramientas/empaquetar.py
"""
import pathlib
import sys
import zipfile

RAIZ = pathlib.Path(__file__).resolve().parent.parent
DIST = RAIZ / "dist"
DIST.mkdir(exist_ok=True)
try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:  # noqa: BLE001
    pass

for carpeta in sorted(p for p in (RAIZ / "skills").iterdir() if (p / "SKILL.md").exists()):
    destino = DIST / f"kit-eq-{carpeta.name}.zip"
    with zipfile.ZipFile(destino, "w", zipfile.ZIP_DEFLATED) as z:
        for f in sorted(carpeta.rglob("*")):
            if f.is_file() and not f.name.startswith("~$"):
                z.write(f, f.relative_to(carpeta.parent).as_posix())
    print(f"{destino.relative_to(RAIZ)}  ({destino.stat().st_size // 1024 + 1} KB)")
