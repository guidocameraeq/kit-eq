# Trabajo del Capataz: Arrancar

Dejás la carpeta del tema armada **según la carpeta modelo**, con su `CLAUDE.md` completo, haciendo pocas preguntas. Así cualquier conversación nueva sabe de qué se trata y dónde quedaron. Seguí las **reglas de oro** del `SKILL.md`.

## La carpeta modelo

Es la carpeta `carpeta-modelo/` del Capataz, al lado de `trabajos/`. Toda carpeta de tema tiene estas piezas:

| Pieza | Para qué |
|---|---|
| `CLAUDE.md` | De qué se trata el tema y sus reglas |
| `LEEME-PRIMERO.md` | El mapa de la carpeta, para la persona |
| `SESSION_HANDOFF.md` | Dónde quedamos y qué sigue |
| `CHANGELOG.md` | Una línea por día con lo hecho |
| `RECETA.md` | Los pasos del proceso. **Solo si el tema se repite** |
| `originales/` | **Copias** de los archivos con los que se trabaja |
| `resultados/` | Lo que arma Claude |

**Huecos** son las marcas que piden completar algo: `{{...}}`, texto entre corchetes que pide un dato (`[completar]`, `[Tema de la carpeta]`, `[NOMBRE]`, `[...]`), `(completar)`, o una sección con el título y nada abajo. Los links (`[texto](dirección)`) y las casillas (`- [ ]`) no son huecos.

## Paso 0: ¿qué hay en la carpeta?

Mirá qué hay (solo los nombres) y, si existe `CLAUDE.md`, leelo. Revisá estos casos **en este orden** y quedate con el primero que se cumpla:

| # | Lo que encontrás | Qué hacés |
|---|---|---|
| 1 | **Subcarpetas que ya son carpetas de tema** (tienen su `CLAUDE.md`) | **Es la carpeta madre**, donde viven todos los temas. Preguntá: *"¿Armo el tema nuevo como una subcarpeta acá adentro? (Recomendado)"*. Con el sí, trabajá en esa subcarpeta y al final avisá que la próxima vez abran la conversación con esa subcarpeta |
| 2 | **Muchas cosas que no son de un tema** (es Documentos, el Escritorio o una carpeta con temas mezclados) | No armes acá. Pedí que creen una carpeta vacía para el tema y que abran la conversación con esa carpeta |
| 3 | **Todas las piezas** (`RECETA.md` solo si el tema se repite) y un `CLAUDE.md` **sin huecos** | **Ya está armada.** Decí *"Esta carpeta ya está armada. ¿La retomamos (decí **inicio**) o armamos otra para un tema distinto?"* y pará. Si te llamó `inicio`, no le pidas que diga inicio: seguí con los pasos 3 a 6 de `inicio` |
| 4 | **Algunas piezas**, o un `CLAUDE.md` **con huecos** | **A medio armar**, casi siempre una copia de la carpeta modelo del curso. Decí *"Esta carpeta está a medio armar: la completo con unas preguntas."* En el Paso 4 **completás lo que hay** y **sumás las piezas que faltan** |
| 5 | **Ninguna pieza** (vacía, o solo con algún archivo de trabajo suelto) | **Carpeta nueva.** Decí *"Esta carpeta todavía no tiene nada del método: armo tu carpeta según la carpeta modelo, con unas preguntas."* |

Si te llamó `inicio`, ya avisó que va a armar la carpeta: no repitas el aviso de las filas 4 y 5 y pasá directo al Paso 1.

Si hay archivos de trabajo sueltos (por ejemplo, un Excel), no los toques: en la pregunta 5 ofrecé copiarlos a `originales/`.

## Paso 1: lo que ya sabés

Juntá lo que ya sabés de la persona: sus instrucciones (nombre, puesto, área, sistemas que usa, a quién le reporta), lo que dijo al pedirte la carpeta y lo que ya esté escrito en un `CLAUDE.md` a medio armar. Confirmalo en **una línea**, por ejemplo: *"Por lo que tengo de vos, trabajás en tesorería y usás el sistema de la empresa y Excel."* No es una pregunta: seguí directo con la primera que falte.

## Paso 2: las preguntas (5 como máximo, de a una)

Saltá las que ya estén respondidas.

1. **¿De qué se trata?** Una o dos frases.
2. **¿Cada cuánto se hace?** Una sola vez / cada semana / cada mes / otra. Si tiene una fecha clave (un vencimiento, un cierre de mes), anotala. **Si se repite, es un proceso: lleva `RECETA.md`.**
3. **¿Con qué trabajás?** Qué archivos o sistemas: Excel exportado del sistema, PDFs, mails, un listado. Si sale "datos del SQL" o "del sistema", aclará que eso se saca con `reportes` en la pestaña Code, y que el Excel que salga se copia a `originales/`.
4. **¿Qué tiene que salir y para quién?** Excel / Word o PDF / texto para un mail / otra, y a quién se le manda. Con eso definís el formato (por ejemplo: Excel con totales por fórmula; fechas dd/mm/aaaa; importes $ 1.234,56).
5. **¿Ya hay archivos de esto?**
   - Si ya están dentro de la carpeta del tema, ofrecé copiarlos vos a `originales/`.
   - Si están en otro lado: en **Cowork** solo ves la carpeta conectada; anotá que, cuando la carpeta esté armada, los peguen directo en `originales/` (clic derecho > Copiar, y Pegar). En **Code**, si te dicen la ruta exacta, los copiás vos; si no, lo mismo que en Cowork.

Si te sobra una pregunta, usala para **¿Quién revisa o aprueba el resultado?** Si no, va "(a confirmar)".

Si en la charla aparece una regla del negocio ("los importes van sin IVA") o una sigla ("CC = cuenta corriente"), anotala para el `CLAUDE.md`. **No preguntes por reglas ni por siglas:** se van sumando con el uso, en cada cierre.

## Paso 3: el plano y el OK

Mostrá, en pocas líneas:
- Qué vas a crear y qué vas a completar (lista de piezas). Lo que ya existe y no se toca, decilo.
- El resumen del `CLAUDE.md`: de qué se trata, quién y para quién, cada cuánto, con qué se trabaja, qué tiene que salir y las reglas que entendiste.
- Si es proceso: que va `RECETA.md` y que los pasos se completan la primera vez que lo hagan juntos.
- Si vas a copiar archivos: cuáles.

Preguntá: **¿Lo armo así? / Cambiar algo / Cancelar.** Sin un sí, no escribís nada.

## Paso 4: armar o completar

Partí de los archivos de `carpeta-modelo/`. Reemplazá **todos** los `{{...}}`; si un dato no se sabe, poné `(a confirmar)`. No dejes ningún hueco en los archivos.

| Hueco | Qué va |
|---|---|
| `{{TEMA}}` | Un título corto del tema ("Conciliación bancaria mensual") |
| `{{FECHA}}` | La fecha de hoy, dd/mm/aaaa |
| `{{DE_QUE_SE_TRATA}}` | Una o dos frases (pregunta 1) |
| `{{QUIEN_LO_HACE}}` | La persona y su puesto, de lo que ya sabías |
| `{{PARA_QUIEN}}`, `{{QUIEN_APRUEBA}}` | De la pregunta 4 y la pregunta extra, o "(a confirmar)" |
| `{{CADA_CUANTO}}` | Frecuencia y fecha clave (pregunta 2) |
| `{{INSUMOS}}`, `{{SALIDA_Y_FORMATO}}` | Renglones que empiezan con `- `. Si no se sabe: `- (a confirmar)` |
| `{{REGLAS_NEGOCIO}}`, `{{PALABRAS}}` | Renglones que empiezan con `- `. Si no hay nada: `- (todavía nada: se suman en cada cierre)` |
| `{{PRIMER_PASO}}` | El primer paso concreto del trabajo ("Pegar el extracto de septiembre en `originales/` y armar la conciliación") |
| En `RECETA.md`: `{{OBJETIVO}}`, `{{CUANDO}}`, `{{APRUEBA}}` | De las preguntas |
| En `RECETA.md`: `{{INSUMO}}`, `{{SALIDA}}` | Un renglón por insumo y por salida (repetí el renglón) |
| En `RECETA.md`: la fila de Pasos | Una sola fila: `\| 1 \| (se completa la primera vez que lo hagamos juntos) \| — \| — \|` |

**Si la carpeta estaba a medio armar:** no reemplaces un archivo entero. Completá sus huecos con lo que salió de las preguntas. Si a su `CLAUDE.md` le falta alguna sección de la carpeta modelo (por ejemplo "Reglas del negocio" o "Palabras de acá"), agregala al final. Lo que la persona ya había escrito queda como está.

1. `originales/` y `resultados/`, si no existen.
2. Si hubo OK para copiar archivos que ya estaban en la carpeta: copiarlos (nunca mover) a `originales/` y contar cuántos había y cuántos quedaron. Si alguno no se pudo copiar, anotalo para el punto 5.
3. `CLAUDE.md`.
4. `LEEME-PRIMERO.md`. Si no hay receta, borrá la fila de `RECETA.md`.
5. `SESSION_HANDOFF.md`: en "Qué hicimos" poné **solo lo que de verdad quedó hecho** (si una copia falló, va en "Pendientes"). En "Qué sigue", el primer paso concreto. Si ya existía con contenido real, no lo pises: sumá lo nuevo.
6. `CHANGELOG.md`: si ya existía, agregá la línea de hoy arriba de todo.
7. `RECETA.md`, **solo si se repite**.

## Paso 5: cierre del trabajo

Si te llamó la **Bienvenida**, no hagas este paso: ella sigue. Si no, decí corto:
- Qué quedó armado o completado (lista de piezas).
- Si quedaron archivos por traer: *"Pegá tus archivos en `originales/`."*
- **Si te llamó `inicio`:** preguntá *"¿Seguimos con el tema acá mismo? (Recomendado) / Lo dejo para otra conversación"*. Si sigue, contá en una línea qué sigue (lo de `SESSION_HANDOFF.md`), sumá *"Cuando termines por hoy, decí **cierre** y anoto dónde quedamos."* y arrancá a trabajar.
- **Si no:** *"Abrí una conversación nueva en esta carpeta y decí **inicio**. Al terminar, decí **cierre**."*
- Si es proceso: *"La primera vez que lo hagamos, al cerrar te propongo los pasos para la receta."*
