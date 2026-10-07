# kit eQ

El **método de la carpeta** para trabajar con Claude en la oficina, empaquetado como plugin.

> Claude se olvida de una conversación a otra. La carpeta, no.

Cada tema de trabajo vive en su carpeta, con un `CLAUDE.md` (de qué se trata), un `SESSION_HANDOFF.md` (dónde quedamos), un `CHANGELOG.md` (qué se hizo cada día), `originales/` (copias) y `resultados/` (lo que arma Claude). Con dos palabras, **inicio** y **cierre**, cualquier conversación nueva retoma donde quedó la anterior.

Está pensado para gente que **no programa**: todo en criollo, sin jerga y sin escribir archivos a mano.

## Instalación

**En la pestaña Code** de la app de escritorio, pegá estas dos líneas (de a una):

```
/plugin marketplace add guidocameraeq/kit-eq
/plugin install kit-eq@kit-eq
```

**En Cowork o Chat** (cuentas Pro): primero se activa "Code execution and file creation" y después las skills se suben de a una como ZIP en Configuración (Settings o Customize) > Skills. Para Cowork alcanzan `capataz`, `inicio` y `cierre`; `configurar` y `reportes` son solo de Code. Los ZIP se arman con `py herramientas/empaquetar.py` (quedan en `dist/`, cada uno con la carpeta de la skill y su `SKILL.md` adentro).

> Probado el 07/10/2026 con la línea de comandos de Claude Code, desde la carpeta local: `claude plugin validate` pasa y `claude plugin marketplace add` + `claude plugin install kit-eq@kit-eq` instalan las 5 skills. NO VERIFICADO: la instalación desde GitHub (el repo todavía no está publicado), los comandos `/plugin` en la pestaña Code de la app de escritorio y la subida de los ZIP en Cowork Pro. Ver CHANGELOG.

## Qué hace cada skill

| Skill | Para qué | Dónde anda |
|---|---|---|
| `configurar` | Deja la PC lista una sola vez: Python y librerías de documentos, las skills oficiales de Excel/Word/PDF, el CLAUDE.md global con los principios y tu puesto, guía para pegar las instrucciones en Cowork y en el Perfil, y la carpeta Reportes. | Code |
| `capataz` | Arranca un tema nuevo: 5 preguntas de a una y deja la carpeta armada (con `RECETA.md` si el tema se repite). | Cowork y Code |
| `inicio` | Lee la carpeta y te cuenta en 3 líneas dónde quedaron y qué sigue. Si hay receta, la corre paso a paso con un control por paso. | Cowork y Code |
| `cierre` | Deja al día `SESSION_HANDOFF.md` y `CHANGELOG.md`, y pregunta si actualiza la receta. | Cowork y Code |
| `reportes` | Del pedido en criollo a un Excel con datos de las vistas del SQL Server, en **solo lectura**, con totales por fórmula y hoja de control. | **Solo Code**, en la oficina o con VPN |

Próximamente: `ordenar` (ordenar una carpeta sin borrar nada) y `anotar` (convertir un proceso en receta).

## Qué NO hace

- No borra ni pisa archivos. Los originales no se tocan: se trabaja sobre copias.
- No modifica la base de datos: `reportes` solo hace `SELECT` sobre vistas.
- No saca datos del SQL desde Cowork: Cowork corre en la nube y no llega a la red de la oficina.
- No trae datos de la empresa: la conexión (`conexion-eq.json`) y el catálogo de vistas (`vistas.md`) son privados y se copian desde la carpeta compartida. En este repo solo hay ejemplos con valores inventados.

## Los principios

`skills/configurar/principios.md` es la fuente única de "cómo trabaja Claude con el equipo": rol, cómo hablar, verificar siempre, orden, memoria, seguridad y formatos de Argentina. `configurar` lo vuelca en el CLAUDE.md global de Code y guía el pegado en Cowork.

## Para quien mantiene el kit

- Antes de cada commit o push: `py herramientas/revisar.py` (frontmatter de las skills, manifiestos y búsqueda de datos privados).
- Lista privada de nombres internos para esa revisión: `../.kit-eq-prohibidas.txt` (fuera del repo).
