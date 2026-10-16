# CHANGELOG — kit eQ

## 0.2.0 — 16/10/2026 (etapa A, para la Clase 1)

### Cambiado
- **Dos paquetes en una tienda.** `plugins/kit-eq/` (capataz, inicio y cierre: Cowork y Code) y `plugins/kit-eq-code/` (configurar y reportes: solo Code). El `marketplace.json` lista los dos. Los archivos de mantenimiento (`docs/`, `herramientas/`, `CLAUDE.md`) ya no se instalan.
- **`capataz`** pasa a ser corto: decide qué trabajo toca y lee solo ese archivo de `trabajos/`.
  - **Bienvenida** (nuevo): la primera vez explica el método, arma la primera carpeta y enseña el ciclo inicio y cierre.
  - **Arrancar**: no repregunta lo que ya está en las instrucciones de la persona. **Sabe cuál es la carpeta modelo** (`capataz/carpeta-modelo/`, antes `plantillas/`) y se fija pieza por pieza qué hay:
    - Carpeta vacía: la arma.
    - A medio armar (por ejemplo, la copia de la Clase 0): completa los huecos y suma lo que falta, sin pisar lo escrito.
    - Ya armada: ofrece retomar.
    - Carpeta madre: arma el tema como subcarpeta.
  - **Guía** (nuevo): qué se puede hacer, por tareas y con la frase para pedirlo.
- **Plantilla del `CLAUDE.md`** con secciones nuevas: "Quién y para quién", "Cada cuánto", "Reglas del negocio" y "Palabras de acá". Las dos últimas crecen con el uso.
- **`cierre`** propone las reglas del negocio y las palabras nuevas para el `CLAUDE.md`, siempre con OK.
- **`inicio`** en una carpeta vacía o a medio armar no se frena: avisa y sigue directo con el Arrancar del Capataz.
- **`README.md`** es la guía del alumno: instalar, la primera vez, las tres palabras, actualizaciones y qué hacer si algo falla.
- **`revisar.py`** controla cada entrada del marketplace contra su `plugin.json`, con `name` y `version`. **`empaquetar.py`** arma `dist/kit-eq.zip` para el plan B (Upload plugin).

### Probado
- `claude plugin validate` pasa en la tienda y en los dos paquetes.
- Instalación desde la carpeta local con la línea de comandos, en una configuración aislada: `kit-eq` trae capataz, cierre e inicio; `kit-eq-code` trae configurar y reportes.
- Ensayo real en Code (modelo sonnet, alumna ficticia de tesorería):
  - **Bienvenida completa:** método en 5 líneas, no repregunta el puesto, 5 preguntas de a una, el plano, no escribe sin OK y arma la carpeta con `RECETA.md`, sin `{{` sin reemplazar. La regla del negocio que surgió en la charla quedó anotada sola.
  - **Carpeta modelo con `[completar]`:** la reconoce y arranca las preguntas sin pisar nada.
  - **Guía:** responde por tareas y avisa que las de Code no están instaladas.
  - **"inicio" en una carpeta vacía:** arranca las preguntas para armar la carpeta modelo, sin escribir nada antes del plano.
  - **"inicio" en una copia de la carpeta modelo de la Clase 0** (huecos `[...]` y un Excel en `originales/`): la completó, sumó `LEEME-PRIMERO.md`, `RECETA.md` y `resultados/`, y no tocó el Excel.
  - **`cierre` después de trabajar:** propuso una regla del negocio y una palabra para el `CLAUDE.md`, no inventó pasos de receta y no escribió nada sin OK.

### NO VERIFICADO
- Todo en Cowork Pro: Add marketplace, Sync automatically y Upload plugin. Tampoco si Cowork espera a que suba la versión.
- La carpeta modelo de la Clase 0 se ensayó con una copia reconstruida (la original está en el taller y no se pudo leer desde la nube).
- Pendiente de la etapa A: la conexión al SQL una sola vez, para todos los proyectos (`configurar` y `reportes` siguen como en 0.1.1).

## 0.1.1 — 07/10/2026 (ronda de pruebas)

### Corregido
- `consultar.ps1`: el filtro de solo lectura se podía esquivar con un texto `'--'` o `'/*'` antes de un `; DROP`. Ahora lee textos, [corchetes], "comillas dobles" y comentarios en una sola pasada; suma KILL, CHECKPOINT y SETUSER; corre la consulta en una transacción que siempre se deshace; avisa en criollo si `conexion-eq.json` está roto o sin clave; tildes bien en los mensajes.
- `conexion-eq.ejemplo.json` era JSON inválido (barra invertida simple). `revisar.py` ahora valida todos los `.json`.
- `csv_a_excel.py`: los enteros que no se suman (nro. de pedido) salían "1,00"; aviso cuando la consulta no trae filas.
- `capataz`: hablaba de tú, inventaba preguntas, miraba la carpeta Descargas del usuario y anotaba en SESSION_HANDOFF una copia que había fallado.
- `inicio`: leía las 5 líneas más viejas del CHANGELOG; ofrecía correr una receta sin pasos.
- `cierre`: escribía sin mostrar el borrador; rescata las notas a mano; propone los pasos de la receta.
- `configurar`: `winget` se quedaba esperando que aceptaran condiciones; `py` o `python`.
- `marketplace.json`: descripción que pide `claude plugin validate`.

### Probado
- `claude plugin validate` pasa (queda un aviso esperado: el `CLAUDE.md` de la raíz es para quien mantiene el kit).
- Instalación desde la carpeta local con la línea de comandos (`claude plugin marketplace add` + `install`), en una configuración aislada: aparecen las 5 skills. También `document-skills@anthropic-agent-skills`.
- Ensayo real en Code (modelo sonnet, carpeta de prueba): capataz (3 a 4 preguntas, pide OK, no deja `{{`), inicio con y sin pasos en la receta, cierre (borrador, OK, "qué probamos y no funcionó", receta v2).
- `consultar.ps1`: 13 consultas maliciosas frenadas y 5 legítimas pasan; "SIN RED" en criollo con un servidor inexistente.
- `csv_a_excel.py`: 500 filas con negativos, vacíos y tildes; el TOTAL que calcula Excel real coincide con la hoja Control y con la suma independiente.
- Los ZIP de `empaquetar.py` traen la carpeta de la skill con `SKILL.md` adentro; `dist/` está ignorado.

### NO VERIFICADO (sigue)
- Consulta real contra el SQL Server de la empresa (incluida la transacción que se deshace).
- Instalación desde GitHub (repo sin publicar) y comandos `/plugin` en la pestaña Code de la app de escritorio.
- Subida de los ZIP en Cowork Pro, que Cowork use las skills y escriba en la carpeta conectada.
- `winget` sin administrador, salida a internet para `pip` y política de scripts en las PCs de la empresa.
- Nombres de menús de la app; Excel conectado con el usuario de solo lectura.

## 0.1.0 — 07/10/2026

### Agregado
- Formato plugin (`.claude-plugin/plugin.json` y `marketplace.json`).
- `principios.md` mudado desde el proyecto del curso, sin cambios de texto (sigue siendo BORRADOR v1 con cambios pendientes de Guido).
- Skills: `configurar`, `capataz` (plantillas de carpeta), `inicio`, `cierre`, `reportes` (scripts `consultar.ps1` y `csv_a_excel.py`).
- `herramientas/revisar.py` (frontmatter + datos privados) y `herramientas/empaquetar.py` (ZIP por skill para Cowork).

### Probado
- `consultar.ps1`: frena todo lo que no sea un SELECT (DELETE, `;` con DROP, SELECT INTO, EXEC) y avisa "SIN RED" en criollo cuando no llega al servidor. La exportación a CSV se probó con una tabla armada a mano (con configuración regional es-AR): números con punto, fechas AAAA-MM-DD, tildes y ñ OK.
- `csv_a_excel.py`: Excel abierto en Excel real, la fila TOTAL con `=SUBTOTAL` da el mismo número que la hoja Control; fechas en dd/mm/aaaa; códigos con cero adelante quedan como texto; no pisa archivos.
- Frontmatter de las 5 skills válido (YAML).

### NO VERIFICADO
- Consulta real contra el SQL Server de la empresa.
- Instalación del plugin en Code (`/plugin ...`) y subida de los ZIP en Cowork Pro.
- Que Cowork use las skills y escriba en la carpeta conectada.
- Nombres de menús de la app (Instrucciones globales de Cowork, Perfil, Privacidad).
- `winget` para instalar Python sin permisos de administrador en las PCs de la empresa.
- Excel conectado a SQL Server con el usuario de solo lectura.
