# Diseño del kit eQ — v3

> Acordado en la charla del 16/10/2026 (sesión en la nube) y aprobado por Guido. Implementado en la versión 0.2.0, salvo lo marcado como pendiente.
> Este archivo es la fuente de diseño del kit. Quien trabaje en el repo (en una PC o en una sesión en la nube) lo lee primero.
> El repo es **público**: acá no van nombres de personas, de la empresa, de sistemas internos ni datos.

## Para quién es
Administrativos que **no programan** (contabilidad, RRHH, tesorería y compras), con Claude Pro en cuentas personales, app de escritorio y PCs con Windows. Trabajan en **Cowork**. Code lo usan poco, para reportes del sistema de la empresa.

**El método de la carpeta:** "Claude se olvida; la carpeta, no". Hay una carpeta por tema, armada según la **carpeta modelo**: `CLAUDE.md` (de qué se trata y sus reglas), `LEEME-PRIMERO.md` (el mapa), `SESSION_HANDOFF.md` (dónde quedamos), `CHANGELOG.md` (qué se hizo cada día), `RECETA.md` (si el trabajo se repite), `originales/` (copias) y `resultados/`. Se usan tres palabras: **capataz**, **inicio** y **cierre**.

## Lo que se sabe de la plataforma (al 16/10/2026)
| Hecho | Fuente | Estado |
|---|---|---|
| Un plugin se agrega en **Customize > Plugins**. **Add > Add marketplace** acepta un repo de GitHub (`owner/repo`), con "Check for updates" y "Sync automatically". **Add > Upload plugin** acepta un `.zip` | [Plugins](https://claude.com/docs/plugins/overview) | Oficial. **NO VERIFICADO en Pro** |
| Lo instalado desde Customize queda en la **cuenta**: anda en Chat, Cowork y Code. Lo instalado desde Code con `/plugin` queda **en esa PC** y no aparece en Cowork | [Plugins](https://claude.com/docs/plugins/overview) y [soporte por superficie](https://claude.com/docs/plugins/platform-support) | Oficial |
| La tienda muestra **todos** los paquetes a todos: no se puede ocultar uno según la superficie | [Host a marketplace](https://code.claude.com/docs/en/plugins/host-marketplace) | Oficial |
| A los usuarios les llega un cambio **solo si sube la `version`** del plugin | Ídem | Oficial en Code; **NO VERIFICADO en Cowork** |
| Cowork en Pro corre **en la nube**, también en la app de escritorio, desde el 06/10/2026: se sacó la opción "Only on your computer". Lee y escribe las carpetas conectadas de la PC mientras la app está abierta | [soporte: Cowork en web, escritorio y celular](https://support.claude.com/en/articles/15520349-use-claude-cowork-on-web-desktop-and-mobile) | Oficial |
| Los conectores locales (servidores MCP que corren en la PC) solo cargan cuando la sesión de Cowork corre en la PC. Por eso **Cowork en Pro no llega al SQL Server de la oficina** | [soporte por superficie](https://claude.com/docs/plugins/platform-support) | Oficial; lo del SQL es la consecuencia |
| Cowork no pide valores de configuración del plugin (`userConfig`); Code sí | Ídem | Oficial |
| Cowork **no** lee skills de la carpeta conectada: las skills son de la cuenta | Ausencia de documentación | Inferencia |
| Cowork lee solo el `CLAUDE.md` de la carpeta | Guías de terceros | NO VERIFICADO. No hace falta: `inicio` lo lee igual |

## Cómo se arma el kit
**El repo es la tienda** (el "marketplace"). Tiene dos paquetes, cada uno en su subcarpeta. Nuestros archivos de trabajo quedan en el repo y **no se instalan**.

```
kit-eq/                              ← el repo = la tienda
├─ .claude-plugin/marketplace.json   ← la vidriera: lista los 2 paquetes
├─ plugins/
│  ├─ kit-eq/        ← para todos: Cowork y Code
│  └─ kit-eq-code/   ← solo Code
└─ docs/  herramientas/  CLAUDE.md  README.md   ← nuestro taller
```

| Paquete | Cómo se instala | Dónde queda |
|---|---|---|
| **`kit-eq`** | Una sola vez, en Customize > Plugins > Add marketplace > `guidocameraeq/kit-eq` > instalar `kit-eq` > prender "Sync automatically" | En la cuenta: Chat, Cowork y Code |
| **`kit-eq-code`** | Solo quien saca reportes, desde la pestaña Code: `/plugin marketplace add guidocameraeq/kit-eq` y `/plugin install kit-eq-code@kit-eq` | En esa PC. No aparece en Cowork |

`kit-eq-code` se ve en la tienda de Cowork igual (no se puede ocultar): su descripción dice "solo Code, no lo instales acá".

**Plan B si Pro no deja agregar el marketplace:** se arma `kit-eq.zip` y cada uno lo sube en Customize > Plugins > Add > Upload plugin. Anda igual, pero no se actualiza solo: cada cambio es un zip nuevo.

**Dos capas:**
- **Cuenta (el kit):** los procedimientos generales. Los mantiene el dev y llegan por sincronización.
- **Carpeta (cada tema):** el conocimiento específico (`CLAUDE.md`, `RECETA.md`). Lo escribe y lo mantiene el Capataz, siempre con el OK de la persona.

## Las skills

**Paquete `kit-eq`** (Cowork y Code; la skill es el mismo archivo en los dos lados)

| Skill | Qué hace | Etapa |
|---|---|---|
| `capataz` | La puerta de entrada: entiende qué necesita la persona y hace el trabajo que corresponde (ver "El Capataz") | Hecho en 0.2.0 |
| `inicio` | Lee la carpeta y cuenta dónde quedaron. Si hay receta, la corre paso a paso. Si la carpeta no está armada, la arma con el Capataz | Hecho en 0.2.0 |
| `cierre` | Muestra el borrador, deja al día el handoff y el changelog, propone pasos para la receta y reglas o palabras nuevas para el `CLAUDE.md`, en un solo borrador y con una sola pregunta | Hecho en 0.2.0 |
| `anotar` | Pasa un proceso que hicieron en el chat a `RECETA.md`, con un control por paso | B |
| `ordenar` | Ordena una carpeta trabajando sobre copias: muestra la tabla, pide OK, nunca borra y lo dudoso va a `_revisar/` | B |
| `verificar` | Segunda opinión: compara un resultado con el original (filas, totales y 3 muestras) | B |
| `cruzar` | Compara dos planillas y lista lo que no coincide | C, si la piden |
| `extraer` | Pasa PDFs y comprobantes a una planilla, con "sin dato" donde falta algo | C |
| `redactar` | Mails y comunicados en el tono de la persona, sin muletillas de IA y con formatos argentinos | C |

**Paquete `kit-eq-code`** (solo Code)

| Skill | Qué hace | Etapa |
|---|---|---|
| `configurar` | La primera vez en la PC: Python, skills oficiales de documentos, el `CLAUDE.md` global con los principios y "Mi puesto", la guía para pegar las instrucciones en Claude, y la **conexión al SQL** (ver "SQL Server") | Existe; la conexión general, **pendiente** |
| `reportes` | Del pedido en criollo a un Excel con datos de las vistas del SQL, en solo lectura, con totales por fórmula y hoja de control | Existe; la conexión general, **pendiente** |

**No se duplican** las skills oficiales de Anthropic (Word, Excel, PowerPoint, PDF y la de crear skills): las nuestras se apoyan en ellas.

## El Capataz
- **Es una skill, no un agente.** Los agentes de un plugin trabajan aparte y no pueden charlar con la persona, y el Capataz pregunta de a una.
- **Es corto.** Escucha, decide qué trabajo toca y lo hace con sus herramientas. No trabaja el tema.
- **Sus trabajos son archivos internos** (`capataz/trabajos/*.md`), no skills visibles: los alumnos ven una sola puerta y Claude no elige la equivocada. Lee solo el trabajo que le toca.

| Trabajo | Qué hace | Cowork | Code | Etapa |
|---|---|---|---|---|
| **Bienvenida** (primera vez) | Explica el método en 5 líneas, revisa que haya una carpeta conectada, hace **Arrancar** con el primer tema de la persona (arma su carpeta según la carpeta modelo), le explica el ciclo **inicio** y **cierre** y termina con lo esencial de la **Guía**. En Code, si la PC no está lista, sugiere `configurar` | Sí | Sí | Hecho en 0.2.0 |
| **Arrancar** | Hasta 5 preguntas, muestra el plano, pide OK y arma la carpeta del tema **con su `CLAUDE.md`** (ver abajo) | Sí | Sí | Hecho en 0.2.0 |
| **Guía** | "¿Qué puedo hacer?": cuenta qué skills tiene, para qué sirve cada una, dónde anda y la frase para usarla, y ofrece arrancarla | Sí | Sí | Hecho en 0.2.0 |
| **Revisar** | Mira una carpeta que ya usan y dice qué falta: el `CLAUDE.md`, archivos sueltos o un proceso sin receta. Propone y, con OK, deriva a `ordenar` o `anotar` | Sí | Sí | B |
| **Nueva skill** | Convierte algo que la persona repite en una skill personal, apoyándose en la skill oficial para crear skills | Arma el `.zip` en la carpeta y guía para subirlo en Customize > Plugins > Add > Upload plugin (NO VERIFICADO en Pro) | La instala en la PC | C |

**Cómo llega a cada cosa:**

| Necesita | De dónde lo saca |
|---|---|
| Los archivos del tema | Solo de la carpeta conectada (Cowork) o de la carpeta de la sesión (Code). No busca por el disco |
| Sus trabajos y la carpeta modelo | De su carpeta en el kit (`trabajos/`, `carpeta-modelo/`) |
| Lo que ya sabe de la persona | De sus instrucciones globales ("Mi puesto"), que Claude ya tiene en cada conversación. **No lo repregunta: lo confirma en una línea** |
| `anotar`, `ordenar` y `verificar` | Las llama por nombre. Vienen en el mismo paquete: si tienen el Capataz, las tienen |
| Qué skills hay instaladas | De la lista de skills que Claude ve en cada conversación, cruzada con el catálogo de la **Guía** (`trabajos/guia.md`), que se actualiza con cada versión del kit |
| Excel, Word, PDF y crear skills | De las skills oficiales, activas en la cuenta |

## El `CLAUDE.md` de cada carpeta
Hay dos niveles, y se repite solo lo mínimo del método:
- **El de la persona:** los principios más "Mi puesto". En Cowork va en las instrucciones globales, que se pegaron en la Clase 0. En Code va en `%USERPROFILE%\.claude\CLAUDE.md`, que deja `configurar`.
- **El de la carpeta:** lo arma **Arrancar**. Sigue una plantilla fija, adaptada a la persona y al tema.

| Sección | Qué dice | De dónde sale |
|---|---|---|
| De qué se trata | Una o dos frases | Pregunta 1 |
| Quién y para quién | Quién lo hace, para quién es y quién aprueba el resultado | Lo de la persona, de sus instrucciones (se confirma); quién aprueba, pregunta opcional |
| Cada cuánto | Una vez, semanal o mensual, y la fecha clave si hay un vencimiento | Pregunta 2. Si se repite, va `RECETA.md` |
| Con qué trabajamos | Los archivos de entrada y de dónde salen (sistema, mail, PDF) | Pregunta 3 |
| Qué tiene que salir | El formato, el nombre del archivo y a quién se le manda | Pregunta 4 |
| Reglas del negocio | Lo que un compañero nuevo no sabría ("los importes van sin IVA") | Lo que surja; si no, "(a completar)". Crece con el uso: `cierre` propone reglas nuevas |
| Palabras de acá | Siglas y nombres propios del tema ("CC = cuenta corriente") | Igual que las reglas: crece con el uso |
| Cómo se trabaja acá | Las reglas del método: copias, verificar, nada se borra, un tema por conversación | Fijo |
| Inicio y cierre | Qué hacer al empezar y al terminar | Fijo |

La pregunta 5 es si ya hay archivos sueltos. Son 5 preguntas como máximo, y lo que la persona ya dijo no se repregunta.

## La carpeta modelo
- **Vive en el kit, dentro del Capataz:** `plugins/kit-eq/skills/capataz/carpeta-modelo/`. Es la única. El material de las clases la toma de acá, no tiene una propia.
- **Piezas:** `CLAUDE.md`, `LEEME-PRIMERO.md`, `SESSION_HANDOFF.md`, `CHANGELOG.md`, `originales/`, `resultados/` y, si el tema se repite, `RECETA.md`.
- **El Capataz la sabe de memoria y se fija qué hay:**
  - Si la carpeta está vacía, la arma.
  - Si está a medio armar (por ejemplo, la copia de la Clase 0 con huecos `[...]`), completa los huecos y suma las piezas que faltan, sin pisar lo escrito.
  - Si ya está completa, ofrece retomar.
  - Si es la carpeta madre de todos los temas, arma el tema nuevo como subcarpeta.
- **`inicio` también la arma:** si la persona dice "inicio" en una carpeta vacía o a medio armar, no se frena: avisa y sigue con el Arrancar del Capataz.

## SQL Server
- **Solo en Code.** Cowork en Pro corre en la nube y no llega a la red de la oficina (ver la tabla de la plataforma). Si en Cowork piden datos del sistema, Claude explica que se sacan en Code y da la frase exacta para pedirlo.
- **Conexión general, una sola vez (pendiente; hoy vive en `Documentos\Reportes`).** La primera vez que se usa, `reportes` (o `configurar`) pide los datos de conexión y los guarda en `%USERPROFILE%\.kit-eq\`, junto con `vistas.md`. Desde ahí la usan **todos los proyectos** de esa PC sin volver a pedirla.
  - **La clave no pasa por el chat.** Se abre el archivo en el Bloc de notas, la persona la escribe y guarda. NO VERIFICADO.
  - Los datos de conexión son de la empresa: **nunca van al repo**. En el repo solo hay ejemplos inventados.
- **Puente con Cowork (pendiente en `reportes`; hoy se copia a mano).** En Code, `reportes` puede dejar el Excel en `originales/` de la carpeta del tema. Después, en Cowork, `inicio` lo ve y se trabaja ahí.

## Guías
| Guía | Para quién | Dónde |
|---|---|---|
| **Portada** | Todos | `README.md`: qué es, por qué sirve, empezar en 3 pasos y qué trae |
| **Guía de uso** | Los alumnos | `docs/GUIA.md`: instalar, la primera vez, el día a día, cómo cuidar las conversaciones, cada skill, recetas, datos del sistema, actualizaciones y problemas frecuentes |
| **Machete** | Los alumnos | `docs/MACHETE.md`: una página para imprimir |
| **Guía dentro del kit** | Los alumnos, mientras trabajan | El trabajo **Guía** del Capataz |
| **Cómo trabajamos** | Quien mantiene el kit | `docs/COMO-TRABAJAMOS.md`: ramas, PR y cómo se publica una versión |

## Gobierno de skills
Una skill creada para una sola persona es **personal** y queda en su cuenta. Si sirve para dos o más, se le pasa al dev, que la revisa y la suma al kit. Antes de sumarla se revisa con `revisar.py` y la lista privada, porque nace de casos reales.

## Reglas para todas las skills
- Criollo rioplatense, una pregunta por vez, opciones con una recomendada, sin jerga.
- Nunca borrar ni mover originales; lo dudoso va a `_revisar/`; contar filas antes y después; los totales los cierra una fórmula de Excel.
- Antes de escribir un archivo, mostrar el borrador y esperar el sí.
- Lo que la skill no puede hacer en una superficie lo dice claro y ofrece la alternativa.
- `description` específica, con cuándo usar y cuándo NO: si es vaga, la skill no se activa y no avisa.

## Hoja de ruta
| Etapa | Qué | Para cuándo |
|---|---|---|
| A | Partir en dos paquetes (subcarpetas). Capataz con Bienvenida, Arrancar (con la plantilla nueva del `CLAUDE.md`) y Guía. `cierre` propone reglas y palabras para el `CLAUDE.md`. README con banner, guía de uso y machete. **Hecho en 0.2.0.** Falta: la conexión SQL general | Clase 1 (16/10) |
| B | Capataz Revisar; `anotar`, `ordenar` y `verificar` | Clase 2 |
| C | Capataz Nueva skill; `cruzar`, `extraer` y `redactar`, según lo que pidan los alumnos | Después |

## Pruebas que solo puede hacer el dev (con cuenta Pro)
1. Add marketplace con este repo en Cowork: ¿deja? ¿aparecen los dos paquetes?
2. Instalar `kit-eq` y usar la Bienvenida del Capataz, `inicio` y `cierre` en una carpeta conectada.
3. Subir el kit como `.zip` con Upload plugin (plan B).
4. Con "Sync automatically" prendido: ¿un cambio llega sin subir la versión, o hace falta subirla?
5. ¿Claude en Cowork ve las instrucciones globales, para que el Capataz no repregunte el puesto?
6. Que el material de las próximas clases use la carpeta modelo del kit en vez de una propia del taller.
