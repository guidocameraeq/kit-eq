# Cómo trabajamos en este repo

> `main` es lo que tienen instalado los alumnos. Por eso `main` se cuida.

## La regla
1. **Nadie toca `main` directo:** ni Guido, ni Claude en la PC, ni una sesión en la nube.
2. Todo cambio va en una **rama** con nombre corto (`capataz-revisar`, `skill-anotar`) y con commits chicos, en español.
3. Antes de cada commit: `py herramientas/revisar.py` (en la nube, `python3`).
4. Se abre un **PR** que dice qué cambia, qué se probó y qué queda NO VERIFICADO.
5. **Guido revisa y mergea.** Antes de mergear corre `py herramientas/revisar.py` en su PC, porque la lista privada de nombres está ahí y la nube no la tiene.

## Publicar a los alumnos
- **Mergear no publica a quien ya lo tiene instalado.** Esas personas reciben una versión nueva solo cuando cambia `version` en `plugin.json`; si no cambia, se quedan con la copia que tienen. **Ojo:** quien instala de cero recibe `main` tal cual, así que en `main` entra solo lo probado. Así funciona en Code; en Cowork está NO VERIFICADO y se prueba con la primera actualización.
- **Para publicar:** un PR que sube la versión y suma la entrada en `CHANGELOG.md`, con lo probado y lo NO VERIFICADO.
- **Qué número cambia:**
  - Un arreglo chico cambia el último número (0.2.0 → 0.2.1).
  - Una skill nueva o un cambio de comportamiento cambia el del medio (0.2.1 → 0.3.0).
  - Nunca se reusa un número viejo.

## Herramientas
- `py herramientas/revisar.py` (en la nube, `python3`): controla los paquetes, las versiones y que no haya datos privados. Va antes de cada commit.
- `py herramientas/empaquetar.py`: arma `dist/kit-eq-<versión>.zip` para el plan B (Upload plugin). Se adjunta a la versión publicada en GitHub (Releases).
- `claude plugin validate .`: el control oficial de la tienda y de los dos paquetes.

## Si algo se rompió
1. En GitHub, botón **Revert** en el PR que lo rompió, y en el mismo arreglo se sube la versión para que les llegue.
2. Después se arregla con calma, en otra rama.

## Sesiones en la nube
Solo ven este repo: no ven el taller del curso ni la lista privada. Trabajan igual que todos, con rama y PR, y nunca hacen push a `main`.
