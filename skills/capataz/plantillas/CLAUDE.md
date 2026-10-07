# {{TEMA}}

> Instrucciones de esta carpeta para Claude. Las armó el Capataz el {{FECHA}}. Se pueden corregir cuando quieras.

## De qué se trata
{{DE_QUE_SE_TRATA}}

## ¿Se repite?
{{SE_REPITE}}

## Con qué trabajamos
- Las **copias** de los archivos van en `originales/`. Los originales de verdad no se tocan.
{{INSUMOS}}

## Qué tiene que salir
- Lo que arma Claude va en `resultados/`, con nombre `AAAA-MM-DD_tema_v01`.
{{SALIDA_Y_FORMATO}}

## Reglas del negocio
{{REGLAS_NEGOCIO}}

## Cómo se trabaja acá
- Un tema por conversación. Si cambia el tema o Claude se pone lento: **cierre** y conversación nueva.
- Antes de algo grande, Claude propone un plan corto y espera el OK.
- Todo número dice de qué archivo salió y se controla contra la fuente antes de usarlo.
- Nada se borra: lo dudoso va a `_revisar/`.

## Al empezar y al terminar
- **inicio**: leé `SESSION_HANDOFF.md` (y `RECETA.md` si existe) y contá en 3 líneas dónde quedamos.
- **cierre**: actualizá `SESSION_HANDOFF.md` y sumá una línea arriba de todo en `CHANGELOG.md`.
