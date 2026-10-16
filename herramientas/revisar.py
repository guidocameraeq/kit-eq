"""revisar.py — control antes de cada commit/push del kit (el repo es PÚBLICO).

Revisa:
  1. Que cada plugins/*/skills/*/SKILL.md tenga frontmatter válido (name igual a la carpeta, description).
  2. Que marketplace.json y el plugin.json de cada paquete sean JSON válidos y coincidan
     (cada entrada del marketplace apunta a una carpeta con su plugin.json y el mismo name).
  3. Que no haya datos privados: archivos prohibidos, IPs, cadenas de conexión con clave,
     y las palabras de una lista privada opcional (una por línea) en ../.kit-eq-prohibidas.txt
     (FUERA del repo, para poder listar nombres internos sin publicarlos).

Uso:  py herramientas/revisar.py      (sale con código 1 si algo falla)
"""
import json
import pathlib
import re
import subprocess
import sys

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:  # noqa: BLE001
    pass

RAIZ = pathlib.Path(__file__).resolve().parent.parent
errores = []


def error(msg):
    errores.append(msg)


# 1. Frontmatter de skills
SKILLS = sorted(RAIZ.glob("plugins/*/skills/*/SKILL.md"))
for skill in SKILLS:
    texto = skill.read_text(encoding="utf-8")
    m = re.match(r"^---\n(.*?)\n---\n", texto, re.S)
    if not m:
        error(f"{skill.relative_to(RAIZ)}: falta el frontmatter (--- ... ---) al principio")
        continue
    campos = {}
    for linea in m.group(1).splitlines():
        if ":" in linea:
            k, v = linea.split(":", 1)
            campos[k.strip()] = v.strip()
    carpeta = skill.parent.name
    if campos.get("name") != carpeta:
        error(f"{skill.relative_to(RAIZ)}: name='{campos.get('name')}' no coincide con la carpeta '{carpeta}'")
    if not re.fullmatch(r"[a-z0-9-]{1,64}", campos.get("name", "")):
        error(f"{skill.relative_to(RAIZ)}: name inválido (minúsculas, números y guiones)")
    desc = campos.get("description", "")
    if not desc:
        error(f"{skill.relative_to(RAIZ)}: falta description")
    elif len(desc) > 1024:
        error(f"{skill.relative_to(RAIZ)}: description de {len(desc)} caracteres (máximo 1024)")

# 2. Manifiestos
try:
    mercado = json.loads((RAIZ / ".claude-plugin" / "marketplace.json").read_text(encoding="utf-8"))
except Exception as e:  # noqa: BLE001
    error(f".claude-plugin/marketplace.json: JSON inválido ({e})")
    mercado = {}
if mercado and mercado.get("name") != "kit-eq":
    error(".claude-plugin/marketplace.json: name debería ser 'kit-eq'")
for entrada in mercado.get("plugins", []):
    nombre = entrada.get("name")
    carpeta = RAIZ / str(entrada.get("source", "")).removeprefix("./")
    manifiesto = carpeta / ".claude-plugin" / "plugin.json"
    try:
        data = json.loads(manifiesto.read_text(encoding="utf-8"))
    except Exception as e:  # noqa: BLE001
        error(f"marketplace.json: la entrada '{nombre}' no tiene un plugin.json válido en {entrada.get('source')} ({e})")
        continue
    if data.get("name") != nombre:
        error(f"{manifiesto.relative_to(RAIZ)}: name='{data.get('name')}' no coincide con la entrada '{nombre}' del marketplace")
    if not data.get("version"):
        error(f"{manifiesto.relative_to(RAIZ)}: falta version (sin version los alumnos no reciben los cambios)")
    if not list(carpeta.glob("skills/*/SKILL.md")):
        error(f"{manifiesto.relative_to(RAIZ)}: el paquete no tiene skills")
    guia = carpeta / "skills" / "capataz" / "trabajos" / "guia.md"
    if guia.exists() and data.get("version") and f"versión **{data['version']}**" not in guia.read_text(encoding="utf-8"):
        error(f"{guia.relative_to(RAIZ)}: el catálogo no dice la versión {data['version']} del plugin.json")

# 3. Datos privados (solo archivos que git va a publicar)
salida = subprocess.run(
    ["git", "ls-files", "--cached", "--others", "--exclude-standard"],
    cwd=RAIZ, capture_output=True, text=True, encoding="utf-8",
)
archivos = [RAIZ / f for f in salida.stdout.splitlines() if f]
prohibidos = {"conexion-eq.json", "vistas.md"}
lista_privada = RAIZ.parent / ".kit-eq-prohibidas.txt"
palabras = []
if lista_privada.exists():
    palabras = [w.strip() for w in lista_privada.read_text(encoding="utf-8").splitlines() if w.strip()]

ip = re.compile(r"\b(?:\d{1,3}\.){3}\d{1,3}\b")
cadena = re.compile(r"(?i)(password|pwd)\s*=\s*[^;\s\"']+")
clave_json = re.compile(r'(?i)"(clave|password|contrase(ñ|n)a)"\s*:\s*"(?!clave-de-ejemplo")[^"]+"')
for f in archivos:
    rel = f.relative_to(RAIZ).as_posix()
    if f.name in prohibidos or (f.name.lower().startswith("conexion") and f.suffix.lower() == ".json" and "ejemplo" not in f.name):
        error(f"{rel}: este archivo es privado y no puede ir al repo")
        continue
    if f.suffix.lower() in {".pyc", ".pyo"} or "__pycache__" in f.parts:
        error(f"{rel}: archivo compilado de Python, no va al repo (está en .gitignore)")
        continue
    if f.suffix.lower() in {".xlsx", ".csv", ".odc"}:
        error(f"{rel}: no se publican datos ni conexiones ({f.suffix})")
        continue
    try:
        texto = f.read_text(encoding="utf-8-sig")
    except (UnicodeDecodeError, FileNotFoundError):
        continue
    if f.suffix.lower() == ".json":
        try:
            json.loads(texto)
        except ValueError as e:
            error(f"{rel}: JSON inválido ({e}). Ojo con la barra invertida: va doble (\\\\).")
    for m in ip.finditer(texto):
        if not m.group(0).startswith(("127.", "0.")):
            error(f"{rel}: parece una IP ({m.group(0)})")
    for m in cadena.finditer(texto):
        error(f"{rel}: parece una clave en una cadena de conexión ({m.group(0)[:12]}...)")
    for m in clave_json.finditer(texto):
        error(f"{rel}: parece una clave real en un JSON ({m.group(1)})")
    for w in palabras:
        if w.lower() in texto.lower():
            error(f"{rel}: contiene una palabra de la lista privada")

if errores:
    print("REVISAR: hay problemas")
    for e in errores:
        print(" -", e)
    sys.exit(1)
print(f"OK: {len(SKILLS)} skills con frontmatter válido, manifiestos OK, sin datos privados a la vista.")
if not palabras:
    print("Aviso: no encontré ../.kit-eq-prohibidas.txt (lista privada de nombres internos); solo revisé IPs y claves.")
