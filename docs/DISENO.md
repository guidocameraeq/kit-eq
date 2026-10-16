# Diseño del kit eQ — v3 (PROPUESTA, 2026-10-16, pendiente del OK de Guido)

> Este archivo es la fuente de diseño del kit. Quien trabaje en el repo (en una PC o en una sesión en la nube) lo lee primero.
> El repo es **público**: acá no van nombres de personas, de la empresa, de sistemas internos ni datos.

## Para quién es
Administrativos que **no programan** (contabilidad, RRHH, tesorería y compras), con Claude Pro en cuentas personales, app de escritorio y PCs con Windows. Trabajan en **Cowork** (el modo de Claude que trabaja con archivos de una carpeta). Code lo usan poco, para reportes del sistema de la empresa.

**El método de la carpeta:** "Claude se olvida; la carpeta, no". Hay una carpeta por tema, con `CLAUDE.md` (de qué se trata y sus reglas), `SESSION_HANDOFF.md` (dónde quedamos), `CHANGELOG.md` (qué se hizo cada día), `RECETA.md` (si el trabajo se repite), `originales/` (copias) y `resultados/`. Se usan dos palabras: **inicio** y **cierre**.

## Lo que se sabe de la plataforma (al 2026-10-16)
| Hecho | Fuente | Estado |
|---|---|---|
| Cowork instala plugins desde **Customize > Plugins**, y **Add marketplace** acepta un repo de GitHub (`owner/repo`). Tiene "Check for updates" y "Sync automatically" | [docs oficiales: Install plugins](https://claude.com/docs/cowork/guide/plugins) | Oficial. **NO VERIFICADO en plan Pro** |
| Un plugin instalado queda en la cuenta: sus skills andan en chat, Cowork y Code | Ídem | Oficial |
| Las skills sueltas se suben como zip en Customize > Skills. Requieren "Code execution and file creation". Son privadas de la cuenta y no se sincronizan | [usecarly.com](https://www.usecarly.com/blog/claude-cowork-skills/), terceros | NO VERIFICADO |
| Cowork **no** lee skills de la carpeta conectada: las skills son de la cuenta | Ausencia de documentación | Inferencia |
| Cowork lee un `CLAUDE.md` de la carpeta conectada | Guías de terceros | NO VERIFICADO |
| En la app nueva, "Cowork is now just Claude": no hay selector Chat/Cowork, y las instrucciones globales están en Settings > General > Instructions for Claude | [soporte oficial](https://support.claude.com/en/articles/13345190-getting-started-with-cowork) y terceros | Lo primero, oficial; la ruta de Settings, NO VERIFICADO |
| Cowork en Pro corre en la nube y **no llega a la red interna** (SQL) | [soporte oficial](https://support.claude.com/en/articles/15520349-use-claude-cowork-on-web-desktop-and-mobile) | Oficial |

## Decisiones v3
1. **Un repo con dos plugins** (en el mismo `marketplace.json`):
   - **`kit-eq`** (compartido): se instala en Cowork y en Code. **Las skills compartidas son el mismo archivo en las dos superficies.**
   - **`kit-eq-code`** (solo Code): `configurar` y `reportes` (SQL de solo lectura). No aparece en Cowork.
2. **Dos capas:**
   - **Cuenta (el kit):** procedimientos generales, mantenidos por el dev y distribuidos por sincronización.
   - **Carpeta (cada tema):** el conocimiento específico (`CLAUDE.md`, `RECETA.md`). Lo escribe y lo mantiene el Capataz, siempre con el OK de la persona.
3. **El Capataz es el jefe de obra del método.** Es una sola skill que se adapta a la superficie:
   | Modo | Code | Cowork |
   |---|---|---|
   | **Arrancar**: hasta 5 preguntas, carpeta y `CLAUDE.md` a medida | Sí | Sí |
   | **Revisar** una carpeta en uso: qué falta anotar, qué se repite sin receta, qué está suelto. Propone y pide OK | Sí | Sí |
   | **Receta**: pasa un proceso a `RECETA.md` (delega en `anotar`) | Sí | Sí |
   | **Crear o mejorar una skill** desde algo que la persona hizo en el chat | La escribe en `~/.claude/skills/` | Arma el zip y guía a la persona para subirlo en Customize (NO VERIFICADO en Pro) |
   | **Instalar skills** | Sí | No: lo hace la persona desde Customize, o le llega por sincronización |
4. **Gobierno de skills:** una skill creada para una sola persona es **personal** y queda en su cuenta. Si sirve para dos o más personas, se le pasa al dev, que la revisa y la suma al kit.
5. **Pool del plugin compartido**, en orden de construcción:
   - **Método:** `inicio`, `cierre`, `capataz` (ya existen; al capataz le faltan los modos revisar y crear skill), `anotar`, `ordenar`.
   - **Oficina:** `verificar` (segunda opinión: filas, totales y 3 muestras contra el original), `cruzar` (dos planillas → diferencias), `extraer` (PDF y comprobantes → planilla, con "sin dato"), `redactar` (mails y comunicados en el tono de la persona, sin muletillas de IA, formatos argentinos).
   - **No se duplican** las skills oficiales de documentos (Word, Excel, PowerPoint, PDF): las nuestras se apoyan en ellas.
6. **Las instrucciones globales** que pega cada persona (`skills/configurar/principios.md` más "Mi puesto") definen **cómo** les habla Claude. Las skills son **procedimientos**. No se pisan ni se repiten.

## Reglas para todas las skills
- Criollo rioplatense, una pregunta por vez, opciones con una recomendada, sin jerga.
- Nunca borrar ni mover originales; lo dudoso va a `_revisar/`; contar filas antes y después; los totales los cierra una fórmula de Excel.
- Antes de escribir un archivo, mostrar el borrador y esperar el sí.
- Lo que la skill no puede hacer en una superficie lo dice claro y ofrece la alternativa.
- `description` específica, con cuándo usar y cuándo NO: si es vaga, la skill no se activa y no avisa.

## Hoja de ruta
| Etapa | Qué | Para cuándo |
|---|---|---|
| A | Partir en dos plugins; capataz con los modos revisar y crear skill; README de instalación para Cowork (Add marketplace) y Code | Clase 1 |
| B | `anotar`, `ordenar`, `verificar` | Clase 2 |
| C | `cruzar`, `extraer`, `redactar`, según lo que pidan los alumnos | Después |

## Pruebas que solo puede hacer el dev (con cuenta Pro)
1. Add marketplace con este repo en Cowork: ¿deja? ¿aparecen los dos plugins?
2. Instalar `kit-eq` y usar capataz, inicio y cierre en una carpeta conectada.
3. ¿Hay una opción para subir un plugin o una skill desde archivo?
4. ¿Cowork lee el `CLAUDE.md` de la carpeta?
