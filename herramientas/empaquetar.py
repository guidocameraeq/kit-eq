"""empaquetar.py — arma el paquete para subir a mano (plan B).

Si en Pro no se puede agregar la tienda (Add marketplace), cada persona sube
dist/kit-eq-<versión>.zip en Customize > Plugins > Add > Upload plugin.
Lleva el contenido de plugins/kit-eq/ (con .claude-plugin/plugin.json adentro).
Solo se empaqueta kit-eq: kit-eq-code es de Code y se instala con /plugin.

Uso:  py herramientas/empaquetar.py
"""
import json
import pathlib
import sys
import zipfile

RAIZ = pathlib.Path(__file__).resolve().parent.parent
PAQUETE = RAIZ / "plugins" / "kit-eq"
DIST = RAIZ / "dist"
DIST.mkdir(exist_ok=True)
try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:  # noqa: BLE001
    pass

version = json.loads((PAQUETE / ".claude-plugin" / "plugin.json").read_text(encoding="utf-8"))["version"]
destino = DIST / f"kit-eq-{version}.zip"
with zipfile.ZipFile(destino, "w", zipfile.ZIP_DEFLATED) as z:
    for f in sorted(PAQUETE.rglob("*")):
        if f.is_file() and not f.name.startswith("~$"):
            z.write(f, f.relative_to(PAQUETE).as_posix())
print(f"{destino.relative_to(RAIZ)}  ({destino.stat().st_size // 1024 + 1} KB)  <- Customize > Plugins > Add > Upload plugin")
