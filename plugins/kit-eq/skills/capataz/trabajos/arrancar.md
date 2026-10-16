# Trabajo del Capataz: Arrancar

Dejás la carpeta del tema armada según la **carpeta modelo**, con su `CLAUDE.md` completo, haciendo pocas preguntas. Así cualquier conversación nueva sabe de qué se trata y dónde quedaron. Seguí las **reglas de oro** del `SKILL.md`.

## La carpeta modelo

Es la carpeta `carpeta-modelo/` del Capataz, al lado de `trabajos/`. Toda carpeta de tema tiene estas piezas:

| Pieza | Para qué | Archivo base en `carpeta-modelo/` |
|---|---|---|
| `CLAUDE.md` | De qué se trata el tema y sus reglas | `CLAUDE.md` |
| `LEEME-PRIMERO.md` | El mapa de la carpeta, para la persona | `LEEME-PRIMERO.md` |
| `SESSION_HANDOFF.md` | Dónde quedamos y qué sigue | `SESSION_HANDOFF.md` |
| `CHANGELOG.md` | Una línea por día con lo hecho | `CHANGELOG.md` |
| `RECETA.md` | Los pasos del proceso. **Solo si el tema se repite** | `RECETA.md` |
| `originales/` | **Copias** de los archivos con los que se trabaja | (carpeta vacía) |
| `resultados/` | Lo que arma Claude | (carpeta vacía) |

## Paso 0: ¿qué hay en la carpeta?

Mirá qué hay (solo los nombres) y, si existe `CLAUDE.md`, leelo. Compará con la carpeta modelo:

| Lo que encontrás | Qué hacés |
|---|---|
| **Ninguna pieza** de la carpeta modelo | **Carpeta nueva.** Decí *"Esta carpeta está vacía: armo la carpeta modelo con unas preguntas."* Seguí con el Paso 1 |
| **Algunas piezas**, o un `CLAUDE.md` con huecos (`[...]`, `{{`, `(completar)` o secciones vacías) | **Carpeta a medio armar**, casi siempre una copia de la carpeta modelo del curso. Decí *"Esta carpeta está a medio armar: la completo con unas preguntas."* Seguí con el Paso 1. En el Paso 4 **completás lo que hay** (llenás los huecos, respetás lo que ya está escrito) y **sumás las piezas que faltan** |
| **Todas las piezas** y el `CLAUDE.md` completo | **Ya está armada.** Decí *"Esta carpeta ya está armada. ¿La retomamos (decí **inicio**) o armamos otra para un tema distinto?"* y pará |
| **Subcarpetas que ya son carpetas de tema** (tienen su `CLAUDE.md`) | **Es la carpeta madre**, donde viven todos los temas. Preguntá: *"¿Armo el tema nuevo como una subcarpeta acá adentro? (Recomendado)"*. Con el sí, trabajá en esa subcarpeta, y al final avisá que la próxima vez abran la conversación con esa subcarpeta |

Si hay archivos sueltos que no son piezas de la carpeta modelo (por ejemplo, un Excel), no los toques: en la pregunta 5 ofrecé copiarlos a `originales/`.

## Paso 1: lo que ya sabés

Antes de preguntar, juntá lo que ya sabés de la persona: sus instrucciones (nombre, puesto, área, sistemas que usa, a quién le reporta), lo que dijo al pedirte la carpeta y lo que ya esté escrito en el `CLAUDE.md` a medio armar. Confirmalo en **una línea**, por ejemplo: *"Por lo que tengo de vos, trabajás en tesorería y usás el sistema de la empresa y Excel."* No es una pregunta: seguí directo con la primera que falte.

## Paso 2: las preguntas (5 como máximo, de a una)

Saltá las que ya estén respondidas.

1. **¿De qué se trata?** Una o dos frases.
2. **¿Cada cuánto se hace?** Una sola vez / cada semana / cada mes / otra. Si tiene una fecha clave (un vencimiento, un cierre), anotala. **Si se repite, es un proceso: lleva `RECETA.md`.**
3. **¿Con qué trabajás?** Qué archivos o sistemas: Excel exportado del sistema, PDFs, mails, un listado. Si sale "datos del SQL" o "del sistema", aclará que eso se saca con `reportes` en la pestaña Code, y que el Excel que salga se trae a esta carpeta.
4. **¿Qué tiene que salir y para quién?** Excel / Word o PDF / texto para un mail / otra. Y a quién se le manda. Con eso definís el formato (por ejemplo: Excel con totales por fórmula; fechas dd/mm/aaaa; importes $ 1.234,56).
5. **¿Ya hay archivos de esto?** Si los hay, ofrecé copiarlos a `originales/` (los originales no se tocan).
   - Si ya están dentro de la carpeta del tema, los copiás vos.
   - Si están en otro lado: en **Cowork** solo ves la carpeta conectada; pedí que los copien (clic derecho > Copiar, y Pegar) adentro de la carpeta del tema y después los pasás vos a `originales/`. En **Code**, si te dicen la ruta exacta, los copiás vos; si no, lo mismo que en Cowork.

Si te sobra una pregunta, usala para **¿Quién revisa o aprueba el resultado?** Si no, va "(a confirmar)".

Si en la charla aparece una regla del negocio ("los importes van sin IVA") o una sigla ("CC = cuenta corriente"), anotala para el `CLAUDE.md`. **No preguntes por reglas ni por siglas:** se van sumando con el uso, en cada cierre.

## Paso 3: el plano y el OK

Mostrá, en pocas líneas:
- Qué vas a crear y qué vas a completar (lista de piezas).
- El resumen del `CLAUDE.md`: de qué se trata, quién y para quién, cada cuánto, con qué se trabaja, qué tiene que salir y las reglas que entendiste.
- Si es proceso: que va `RECETA.md` y que los pasos se completan la primera vez que lo hagan juntos.
- Si vas a copiar archivos: cuáles y a dónde.

Preguntá: **¿Lo armo así? / Cambiar algo / Cancelar.** Sin un sí, no escribís nada.

## Paso 4: armar o completar

Partí de los archivos de `carpeta-modelo/`. Reemplazá **todos** los `{{...}}`; si un dato no se sabe, poné `(a confirmar)`. No dejes ningún `{{` ni `[...]` de la plantilla en los archivos. Las listas (`{{INSUMOS}}`, `{{SALIDA_Y_FORMATO}}`, `{{REGLAS_NEGOCIO}}`, `{{PALABRAS}}`) van como renglones que empiezan con `- `; si no hay nada, `- (todavía nada: se suman en cada cierre)`.

**Si la carpeta estaba a medio armar:** no reemplaces un archivo entero. Completá sus huecos con lo que salió de las preguntas. Si su `CLAUDE.md` no tiene alguna sección de la carpeta modelo (por ejemplo "Reglas del negocio" o "Palabras de acá"), agregala al final. Lo que ya estaba escrito por la persona queda como está.

1. `originales/` y `resultados/`, si no existen.
2. Si hubo OK para copiar archivos: copiarlos (nunca mover) a `originales/`, y contar cuántos había y cuántos quedaron. Si alguno no se pudo copiar, anotalo para el punto 5.
3. `CLAUDE.md`. En "Lo hace" va la persona con su puesto, sacado de lo que ya sabías.
4. `LEEME-PRIMERO.md`. Si hay receta, `{{FILA_RECETA}}` es la fila `| RECETA.md | Los pasos del proceso, para hacerlo siempre igual |` con salto de línea; si no, se borra.
5. `SESSION_HANDOFF.md`: en "Qué hicimos" poné **solo lo que de verdad quedó hecho** (si una copia falló, va en "Pendientes"). En "Qué sigue" poné el primer paso concreto (por ejemplo: "Traer el Excel de septiembre a `originales/` y decir inicio"). Si ya existía con contenido real, no lo pises: sumá lo nuevo.
6. `CHANGELOG.md`: si ya existía, agregá la línea de hoy arriba de todo.
7. `RECETA.md` **solo si se repite**: completá Objetivo, Cuándo, Insumos, Salidas y Quién aprueba. En Pasos dejá una sola fila: `| 1 | (se completa la primera vez que lo hagamos juntos) | — | — |`.

Fechas en formato dd/mm/aaaa.

## Paso 5: cierre del trabajo

Decí, corto:
- Qué quedó armado o completado (lista de piezas).
- Cómo se usa: *"Abrí una conversación nueva en esta carpeta y decí **inicio**. Al terminar, decí **cierre**."*
- Si es proceso: *"La primera vez que lo hagamos, al cerrar te propongo los pasos para la receta."*
