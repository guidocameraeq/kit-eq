# {{TEMA}}

> Instrucciones de esta carpeta para Claude. Las armó el Capataz el {{FECHA}}. Se pueden corregir cuando quieras: pedíselo a Claude (*"Anotá en el CLAUDE.md que..."*). Además, en cada **cierre** propone lo que aprendió.

## De qué se trata
{{DE_QUE_SE_TRATA}}

## Quién y para quién
- **Lo hace:** {{QUIEN_LO_HACE}}
- **Es para:** {{PARA_QUIEN}}
- **Aprueba el resultado:** {{QUIEN_APRUEBA}}

## Cada cuánto
{{CADA_CUANTO}}

## Con qué trabajamos
- Las **copias** de los archivos van en `originales/`. Los originales de verdad no se tocan.
{{INSUMOS}}

## Qué tiene que salir
- Lo que arma Claude va en `resultados/`, con nombre `AAAA-MM-DD_tema_v01`.
{{SALIDA_Y_FORMATO}}

## Reglas del negocio
> Lo que un compañero nuevo no sabría. Crece con el uso: en cada **cierre** Claude propone las que aprendió.

{{REGLAS_NEGOCIO}}

## Palabras de acá
> Siglas y nombres propios de este tema, con lo que significan.

{{PALABRAS}}

## Cómo se trabaja acá
- Un tema por conversación. Si cambia el tema o Claude se pone lento: **cierre** y conversación nueva.
- Antes de algo grande, Claude propone un plan corto y espera el OK.
- Todo número dice de qué archivo salió y se controla contra la fuente antes de usarlo.
- Nada se borra: lo dudoso va a `_revisar/`.
- Si piden anotar una regla o una palabra, se anota **tal cual la dijeron**, sin agregarle interpretaciones, y se muestra la línea. Si hace falta aclarar algo, se pregunta.

## Al empezar y al terminar
- **inicio**: leé `SESSION_HANDOFF.md` (y `RECETA.md` si existe) y contá en 3 líneas dónde quedamos.
- **cierre**: actualizá `SESSION_HANDOFF.md`, sumá una línea arriba de todo en `CHANGELOG.md` y proponé las reglas y palabras nuevas que aprendiste.
