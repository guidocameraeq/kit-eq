# Trabajo del Capataz: Arrancar

Armás la carpeta de un tema con su `CLAUDE.md`, haciendo pocas preguntas, para que cualquier conversación nueva sepa de qué se trata y dónde quedaron. Seguí las **reglas de oro** del `SKILL.md`.

## Paso 0: ¿cómo está la carpeta?

Mirá qué hay en la carpeta del tema (solo los nombres) y si existe `CLAUDE.md`, leelo.

| Lo que encontrás | Qué hacés |
|---|---|
| No hay `CLAUDE.md` ni `SESSION_HANDOFF.md` | **Carpeta nueva:** seguí con el Paso 1 y armala entera |
| Hay un `CLAUDE.md` **sin completar**: tiene `{{`, `[completar]`, `(completar)`, `...` o secciones vacías | **Es la carpeta modelo copiada.** Decí *"Esta es la carpeta modelo: la completamos con unas preguntas."* Seguí con el Paso 1, pero en el Paso 3 **completás lo que ya está**: respetás sus secciones y archivos, solo llenás los huecos. Si le falta una sección de `plantillas/CLAUDE.md`, proponé sumarla en el plano |
| Hay un `CLAUDE.md` completo | **Ya está armada.** Decí *"Esta carpeta ya está armada. ¿La retomamos (decí **inicio**) o armamos otra para un tema distinto?"* y pará |

## Paso 1: lo que ya sabés

Antes de preguntar, juntá lo que ya sabés de la persona: sus instrucciones (nombre, puesto, área, sistemas que usa, a quién le reporta) y lo que dijo al pedirte la carpeta. Confirmalo en **una línea**, por ejemplo: *"Por lo que tengo de vos, trabajás en tesorería y usás el sistema de la empresa y Excel. ¿Este tema es parte de eso?"*

## Paso 2: las preguntas (5 como máximo, de a una)

Saltá las que ya estén respondidas.

1. **¿De qué se trata?** Una o dos frases.
2. **¿Cada cuánto se hace?** Una sola vez / cada semana / cada mes / otra. Si tiene una fecha clave (un vencimiento, un cierre), anotala. **Si se repite, es un proceso: va a llevar `RECETA.md`.**
3. **¿Con qué trabajás?** Qué archivos o sistemas: Excel exportado del sistema, PDFs, mails, un listado. Si sale "datos del SQL" o "del sistema", aclará que eso se saca con `reportes` en la pestaña Code, y que el Excel que salga se trae a esta carpeta.
4. **¿Qué tiene que salir y para quién?** Excel / Word o PDF / texto para un mail / otra. Y a quién se le manda. Con eso definís el formato (por ejemplo: Excel con totales por fórmula; fechas dd/mm/aaaa; importes $ 1.234,56).
5. **¿Ya hay archivos de esto?** Si los hay, ofrecé copiarlos a `originales/` (los originales no se tocan).
   - Si ya están dentro de la carpeta del tema, los copiás vos.
   - Si están en otro lado: en **Cowork** no los podés ver; pedí que los copien (clic derecho > Copiar, y Pegar) adentro de `originales/` y después contás cuántos llegaron. En **Code**, si te dicen la ruta exacta, los copiás vos; si no, lo mismo que en Cowork.

Si te sobra una pregunta, usala para **¿Quién revisa o aprueba el resultado?** Si no, va "(a confirmar)".

Si en la charla aparece una regla del negocio ("los importes van sin IVA") o una sigla ("CC = cuenta corriente"), anotala para el `CLAUDE.md`. **No preguntes por reglas ni por siglas:** se van sumando con el uso, en cada cierre.

## Paso 3: el plano y el OK

Mostrá, en pocas líneas:
- Qué vas a crear o completar (lista de archivos).
- El resumen del `CLAUDE.md`: de qué se trata, quién y para quién, cada cuánto, con qué se trabaja, qué tiene que salir y las reglas que entendiste.
- Si es proceso: que va `RECETA.md` y que los pasos se completan la primera vez que lo hagan juntos.
- Si vas a copiar archivos: cuáles y a dónde.

Preguntá: **¿Lo armo así? / Cambiar algo / Cancelar.** Sin un sí, no escribís nada.

## Paso 4: armar la carpeta

Usá las plantillas de la carpeta `plantillas/` del Capataz. Reemplazá **todos** los `{{...}}`; si un dato no se sabe, poné `(a confirmar)`. No dejes ningún `{{` en los archivos. Las listas (`{{INSUMOS}}`, `{{SALIDA_Y_FORMATO}}`, `{{REGLAS_NEGOCIO}}`, `{{PALABRAS}}`) van como renglones que empiezan con `- `; si no hay nada, `- (todavía nada: se suman en cada cierre)`.

Si es la carpeta modelo, completás sus archivos en vez de crearlos, y creás solo lo que falte.

1. Carpetas `originales/` y `resultados/`, si no existen.
2. Si hubo OK para copiar archivos: copiarlos (nunca mover) a `originales/`, y contar cuántos había y cuántos quedaron. Si alguno no se pudo copiar, anotalo para el punto 5.
3. `CLAUDE.md` (de `plantillas/CLAUDE.md`). En "Lo hace" va la persona con su puesto, sacado de lo que ya sabías.
4. `LEEME-PRIMERO.md` (de `plantillas/LEEME-PRIMERO.md`). Si hay receta, `{{FILA_RECETA}}` es la fila `| RECETA.md | Los pasos del proceso, para hacerlo siempre igual |` con salto de línea; si no, se borra.
5. `SESSION_HANDOFF.md`: en "Qué hicimos" poné **solo lo que de verdad quedó hecho** (si una copia falló, va en "Pendientes"). En "Qué sigue" poné el primer paso concreto (por ejemplo: "Traer el Excel de septiembre a `originales/` y decir inicio").
6. `CHANGELOG.md`.
7. `RECETA.md` **solo si se repite**: completá Objetivo, Cuándo, Insumos, Salidas y Quién aprueba. En Pasos dejá una sola fila: `| 1 | (se completa la primera vez que lo hagamos juntos) | — | — |`.

Fechas en formato dd/mm/aaaa.

## Paso 5: cierre del trabajo

Decí, corto:
- Qué quedó armado (lista de archivos).
- Cómo se usa: *"Abrí una conversación nueva en esta carpeta y decí **inicio**. Al terminar, decí **cierre**."*
- Si es proceso: *"La primera vez que lo hagamos, al cerrar te propongo los pasos para la receta."*
