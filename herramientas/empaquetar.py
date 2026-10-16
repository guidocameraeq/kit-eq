"""empaquetar.py — arma en dist/ los paquetes para subir a mano (plan B).

Plan B, si en Pro no se puede agregar la tienda (Add marketplace):
  - dist/kit-eq.zip: el paquete entero, para Customize > Plugins > Add > Upload plugin.
    Lleva el contenido de plugins/kit-eq/ (con .claude-plugin/plugin.json adentro).
  - dist/skills/kit-eq-<skill>.zip: una skill por ZIP, para Customize > Skills (último recurso).
Solo se empaqueta el paquete kit-eq: kit-eq-code es de Code y se instala con /plugin.

Uso:  py herramientas/empaquetar.py
"""
import pathlib
import sys
import zipfile

RAIZ = pathlib.Path(__file__).resolve().parent.parent
PAQUETE = RAIZ / "plugins" / "kit-eq"
DIST = RAIZ / "dist"
(DIST / "skills").mkdir(parents=True, exist_ok=True)
try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:  # noqa: BLE001
    pass


def archivos(carpeta):
    return [f for f in sorted(carpeta.rglob("*")) if f.is_file() and not f.name.startswith("~$")]


destino = DIST / "kit-eq.zip"
with zipfile.ZipFile(destino, "w", zipfile.ZIP_DEFLATED) as z:
    for f in archivos(PAQUETE):
        z.write(f, f.relative_to(PAQUETE).as_posix())
print(f"{destino.relative_to(RAIZ)}  ({destino.stat().st_size // 1024 + 1} KB)  <- Upload plugin")

for carpeta in sorted(p for p in (PAQUETE / "skills").iterdir() if (p / "SKILL.md").exists()):
    destino = DIST / "skills" / f"kit-eq-{carpeta.name}.zip"
    with zipfile.ZipFile(destino, "w", zipfile.ZIP_DEFLATED) as z:
        for f in archivos(carpeta):
            z.write(f, f.relative_to(carpeta.parent).as_posix())
    print(f"{destino.relative_to(RAIZ)}  ({destino.stat().st_size // 1024 + 1} KB)")
