---
name: cierre
description: Cierra la conversación dejando el cuaderno al día - reescribe SESSION_HANDOFF.md (qué hicimos, qué sigue, qué probamos y no funcionó, pendientes) y suma una línea a CHANGELOG.md; si se usó una receta y algo fue distinto, pregunta si la actualiza. Usar cuando dicen "cierre", "cerremos", "terminamos por hoy", "dejalo anotado". NO usar en una carpeta que no está armada (primero capataz).
---

# Cierre: dejar el cuaderno al día

La conversación termina y Claude se va a olvidar de todo. Antes, dejás escrito en la carpeta lo necesario para que la próxima conversación arranque con **inicio** sin que nadie explique nada. Le hablás de vos, en español rioplatense (nunca "tú"), en criollo y sin jerga.

## Dónde anda

- **Cowork** (la casa) y **Code**: escribe en la carpeta conectada o en la carpeta de la sesión.

## Lo que NO hace

- No borra ni mueve archivos.
- No toca `originales/` ni los resultados.
- **No cambia `RECETA.md` sin OK**: propone el cambio y espera.
- No cambia `CLAUDE.md` sin OK (si aprendiste una regla nueva del negocio, proponela).

## Pasos

1. **Repasar la conversación**: qué se hizo, qué se decidió, qué archivos salieron en `resultados/`, qué se probó y no anduvo, qué quedó pendiente.
2. **Primero mostrás, después escribís.** En esta respuesta solo mostrás el borrador (las 4 secciones de abajo, cortas, más la línea del CHANGELOG y, si corresponde, los pasos propuestos para la receta del punto 5) y terminás con *"¿Lo anoto así?"*. **No escribas ningún archivo en la misma respuesta.** Recién con el sí, escribís. Si la persona corrige algo, lo que dice ella manda.
3. **Reescribir entero `SESSION_HANDOFF.md`** con este formato. Antes, leé el que hay: si tiene algo que no salió de un cierre (una nota que agregó la persona a mano, un pendiente viejo que sigue vivo), pasalo a la versión nueva y mostralo en el borrador. Nunca lo pierdas en silencio.
   ```
   # Dónde quedamos

   > Lo escribe Claude cuando decís **cierre**. Se reemplaza entero cada vez.

   **Última vez:** dd/mm/aaaa

   ## Qué hicimos
   - (3 a 8 líneas, con el nombre de los archivos que salieron)

   ## Qué sigue
   - (el próximo paso CONCRETO; nunca "seguir avanzando")

   ## Qué probamos y no funcionó
   - (y por qué, para no repetirlo; o "nada")

   ## Pendientes o dudas
   - (lo que falta confirmar y con quién; o "nada")
   ```
4. **Sumar una línea arriba de todo en `CHANGELOG.md`** (debajo del título y la nota): `- dd/mm/aaaa — qué hicimos y qué decidimos, en una línea.` Si ya hay una línea de hoy, completala en vez de agregar otra.
5. **Receta:**
   - Si hay `RECETA.md` y hoy algo fue distinto (un paso nuevo, un control que falló, una excepción): preguntá *"¿Actualizo la receta?"* y mostrá el cambio. Con OK: aplicalo, subí la versión y sumá una fila al **Registro de cambios** con la fecha y el porqué.
   - Si hay `RECETA.md` con los pasos todavía sin completar y hoy se hizo el proceso: proponé vos los pasos en el borrador, ya escritos como filas de la tabla (acción + control + exacto/criterio); no preguntes si querés proponerlos. Se aplican solo con OK.
   - Si no hay receta y el tema se repite: ofrecé armarla.
6. **Avisar** en 2 líneas: qué quedó anotado y *"Para seguir: conversación nueva en esta carpeta y decís **inicio**."*

## Reglas

- Fechas dd/mm/aaaa.
- Lo que anotó la persona a mano en estos archivos se respeta: no lo borres ni lo resumas sin mostrarlo.
- Si la carpeta no tiene `SESSION_HANDOFF.md` ni `CLAUDE.md`, no la armes acá: ofrecé el Capataz.
