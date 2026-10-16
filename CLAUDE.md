# CLAUDE.md — kit eQ

Plugin de Claude Code / Cowork con el método de la carpeta para administrativos que no programan.

**Antes de tocar nada, leé `docs/DISENO.md`** (diseño v3, decisiones y hoja de ruta).

## Reglas duras
1. **Repo PÚBLICO.** Cero secretos, IPs, servidores, usuarios, claves, nombres de vistas reales o datos de la empresa, en archivos y en mensajes de commit. Lo privado vive en la carpeta compartida (`conexion-eq.json`, `vistas.md`). Antes de cada commit: `py herramientas/revisar.py`.
2. **`skills/configurar/principios.md` es la fuente única de los principios.** No se edita sin pedido de Guido.
3. **Seguridad de las skills:** nunca borrar ni mover originales; trabajar sobre copias; verificar números contra la fuente; SQL solo `SELECT` sobre vistas.
4. **Cada skill dice dónde anda (Cowork / Code) y qué NO hace.** Lo de SQL, solo Code.
5. **Lo no probado se marca NO VERIFICADO** en la skill y en el CHANGELOG.

## Estilo
- Español rioplatense, en criollo, para no programadores. Pasos numerados, una pregunta por vez, opciones con una recomendada.
- SKILL.md con frontmatter `name` (igual a la carpeta) y `description` (cuándo usar y cuándo NO).

## Estructura
- `.claude-plugin/` manifiestos del plugin y del marketplace.
- `skills/<nombre>/SKILL.md` + sus archivos (plantillas, scripts).
- `herramientas/` revisar y empaquetar (no son skills).

## Commits
Chicos, en español. Antes de cada commit: `py herramientas/revisar.py`. Ramas, PR y cómo se publica una versión: `docs/COMO-TRABAJAMOS.md`.

## Trabajo en una sesión en la nube
La sesión en la nube solo ve este repo (no el taller del curso ni la lista privada de nombres). Trabajá en una **rama nueva** y abrí un **PR**: nunca push directo a `main`. Guido revisa y mergea. No inventes nombres de personas, de la empresa ni de sistemas: usá ejemplos genéricos verosímiles.
