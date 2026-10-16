# CHANGELOG — kit eQ

## 0.2.4 de `kit-eq-code` — 16/10/2026 — la carpeta Reportes es siempre la misma

### Cambiado
- `consultar.ps1` busca la conexión en `Documentos\Reportes\conexion-eq.json` y deja los resultados en `Documentos\Reportesesultados\`, **se abra la sesión de Code en la carpeta que sea**. Antes dependía de que Claude usara la ruta completa. Una ruta que no sea completa se toma desde esa carpeta.
- `reportes` ya no pasa `-Conexion` y usa la ruta que informa el script para armar el Excel.
- `probar_consultar.ps1` suma la prueba de que, sin `-Conexion`, busca en la carpeta Reportes.

## 0.2.3 de `kit-eq-code` — 16/10/2026 — catálogo de vistas dentro del kit

### Cambiado
- `vistas.md` viaja dentro del kit (`skills/reportes/vistas.md`) y se actualiza con cada versión. Antes tenía que copiarlo cada alumno. La conexión (`conexion-eq.json`) sigue privada y por PC.
- `reportes` lee el catálogo del kit, avisa si todavía es un EJEMPLO y no consulta, e ignora copias viejas en Reportes.
- `configurar` ya no copia `vistas.md`.
- `revisar.py` permite `vistas.md` solo en esa ruta.
- `vistas.md` ahora es el catálogo real de las 8 vistas validadas (reglas de oro, mapa de cruces, checklist) más una ficha por cada una de las 8 en `vistas/`.
- `consultar.ps1` solo deja pasar consultas sobre las vistas de `vistas.md` (también frena coma entre tablas, `APPLY`, tablas del sistema y otras bases). Lo cubre `herramientas/probar_consultar.ps1` (19 pruebas, sin conectarse al servidor). Antes solo lo limitaba una regla escrita: el usuario del servidor lee todo.
- `reportes`: fechas siempre `AAAAMMDD`, y 0 filas no es "no hay datos" (confirmar la red antes).

### NO VERIFICADO
- Que la skill encuentre el catálogo en la carpeta base del plugin instalado, en Code.

## 0.2.2 de `kit-eq-code` — 16/10/2026 (actualizaciones en Code)

### Cambiado
- `configurar` suma un paso para prender la actualización automática de la tienda en Code (viene apagada para tiendas de terceros) e instalar `kit-eq-code`; avisa que `kit-eq` ya llega a Code desde la cuenta.
- `principios.md`: el cierre hace una sola pregunta (también para la receta).
- Guía y `COMO-TRABAJAMOS`: cómo les llegan las actualizaciones en Cowork, en Code y con el zip.
- `kit-eq` sigue en 0.2.1.

### NO VERIFICADO
- Que los menús de **Marketplaces** y **Enable auto-update** sean iguales en la pestaña Code de la app de escritorio.
- Cómo se comporta **Sync automatically** en Cowork Pro.

## 0.2.1 — 16/10/2026 (pulido para presentar)

### Probado
- Ensayo en Code (alumna ficticia):
  - **"inicio" en la carpeta madre:** lista los temas y no escribe nada.
  - **"Corramos la receta":** dispara `inicio`.
  - **"inicio" en una carpeta vacía:** arranca a armarla.
  - **"Anotá en el CLAUDE.md que...":** no dispara `cierre`.
- `claude plugin validate` e instalación desde GitHub (0.2.0) con la línea de comandos.

### Corregido
- **Se había colado un archivo compilado de Python** (`__pycache__`) en el repo y en el paquete. Se sacó, va en `.gitignore` y `revisar.py` lo frena.
- **Las skills se contradecían** sobre qué pasa después de armar la carpeta. Ahora, si a Arrancar lo llamó `inicio`, ofrece seguir ahí mismo y enseña a decir **cierre**; si no, manda a una conversación nueva.
- **`inicio` en la carpeta madre o en Documentos** ya no ofrece armar la carpeta ahí: muestra los temas y explica qué abrir.
- **Avisos repetidos e idas y vueltas:**
  - inicio y Arrancar ya no repiten el mismo aviso.
  - Una carpeta ya armada no manda a decir "inicio" otra vez.
  - Los huecos se definen igual en los dos.
- **Bienvenida:** si Arrancar paró, no sigue como si hubiera armado algo.
- **El primer `SESSION_HANDOFF.md`** ya no dice "decir inicio" como próximo paso: dice el primer paso del trabajo.
- **Frases del machete que no activaban nada:** "corramos la receta" ahora activa `inicio`, y "anotá en el CLAUDE.md que..." ya no activa `cierre`.
- **`inicio`:** no hace dos preguntas juntas cuando pasó más de un mes.
- **`configurar`:** no repregunta lo que ya está en "Mi puesto".
- **"Anotá en el CLAUDE.md que..."** se anota tal cual lo dijo la persona, sin agregarle interpretaciones, y se muestra la línea.

### Cambiado
- **Capataz:** suma la sección "Lo que NO hace", y "revisá esta carpeta" avisa que viene más adelante.
- **Documentación:**
  - README: los requisitos antes de empezar, cómo elegir la carpeta (el **+** del cuadro donde se escribe) y el badge "pensado para Cowork · Code" hasta probarlo en Cowork.
  - Guía de uso:
    - Los menús van en inglés, como los muestra la app, con la traducción.
    - Los datos del sistema arrancan en `Documentos\Reportes`.
    - Suma dos problemas frecuentes.
    - El zip del plan B se pide a quien da el curso, o se baja de Releases si está publicado.
  - Las herramientas de mantenimiento se explican en "Cómo trabajamos".
- **Banner:** sin la frase repetida.
- **`plugin.json`:** dirección del repo (`homepage`).

## 0.2.0 — 16/10/2026 (para la Clase 1)

### Para quien ya lo tenía
- **Cowork:** si subiste skills sueltas en Customize > Skills (capataz, inicio, cierre), borralas y instalá el paquete desde la tienda (ver la guía de uso).
- **Code:** `configurar` y `reportes` pasaron al paquete `kit-eq-code`: `/plugin install kit-eq-code@kit-eq`.

### Cambiado
- **Dos paquetes en una tienda:**
  - `plugins/kit-eq/`: capataz, inicio y cierre, para Cowork y Code.
  - `plugins/kit-eq-code/`: configurar y reportes, solo para Code.
  - Los archivos de mantenimiento (`docs/`, `herramientas/`, `CLAUDE.md`) ya no se instalan.
- **`capataz` pasa a ser corto:** decide qué trabajo toca y lee solo ese archivo de `trabajos/`.
  - **Bienvenida** (nuevo): la primera vez explica el método, arma la primera carpeta y enseña el ciclo inicio y cierre.
  - **Arrancar:** conoce la **carpeta modelo** (`capataz/carpeta-modelo/`, antes `plantillas/`) y revisa pieza por pieza qué hay:
    - **Carpeta madre:** arma el tema como subcarpeta.
    - **Documentos o el Escritorio:** no arma ahí.
    - **Ya armada:** ofrece retomar.
    - **A medio armar** (por ejemplo, la copia de la Clase 0): completa los huecos y suma lo que falta, sin pisar lo escrito.
    - **Vacía:** la arma.
  - **Arrancar** tampoco repregunta lo que ya está en las instrucciones de la persona.
  - **Guía** (nuevo): qué se puede hacer, por tareas, con la frase para pedirlo.
- **La plantilla del `CLAUDE.md`** suma "Quién y para quién", "Cada cuánto", "Reglas del negocio" y "Palabras de acá". Las dos últimas crecen con el uso.
- **`inicio`:**
  - En una carpeta vacía o a medio armar no se frena: avisa y sigue con el Arrancar del Capataz. Al terminar, ofrece seguir trabajando ahí mismo.
  - No se activa con "saldo de inicio" ni "fecha de inicio".
  - Recuerda que los datos del sistema se sacan en Code.
- **`cierre`:**
  - Propone las reglas del negocio y las palabras nuevas para el `CLAUDE.md`.
  - Junta todo en un solo borrador, con **una sola pregunta**.
  - No inventa pasos de receta.
  - **No se activa con el "cierre de mes" o el "cierre de caja"**.
- **`configurar`:** las instrucciones se pegan en un solo lugar (Configuración > General > Instrucciones para Claude).
- **`reportes`:**
  - Para el Excel conectado lee solo servidor, base y usuario: la clave no pasa por el chat.
  - El control independiente va a un archivo `_control`.
  - Explica los avisos de "ERROR EN LA CONSULTA" y de archivo que ya existe.
- **Documentación:**
  - `README.md` nuevo, con banner, "Empezar en 3 pasos" y el ciclo de trabajo.
  - **Guía de uso** completa (`docs/GUIA.md`) y **machete** de una página (`docs/MACHETE.md`).
- **Herramientas:**
  - `revisar.py` controla cada paquete contra la tienda (`name`, `version`), que la Guía diga la versión del paquete, y detecta claves reales en archivos JSON.
  - `empaquetar.py` arma `dist/kit-eq-<versión>.zip` para el plan B (Upload plugin).

### Corregido
- `csv_a_excel.py`: un CBU de 22 dígitos o un código como "12E3" se convertían en número y perdían dígitos. Ahora los números de más de 15 dígitos y los códigos con letras quedan como texto.

### Probado
- `claude plugin validate` pasa en la tienda y en los dos paquetes.
- Instalación desde la carpeta local con la línea de comandos, en una configuración aislada: `kit-eq` trae capataz, cierre e inicio; `kit-eq-code` trae configurar y reportes.
- Ensayo real en Code (modelo sonnet, alumna ficticia de tesorería):
  - **Bienvenida completa:** método en 5 líneas, no repregunta el puesto, 5 preguntas de a una, el plano, no escribe sin OK y arma la carpeta con `RECETA.md`, sin huecos. Una regla que surgió en la charla quedó anotada sola.
  - **"inicio" en una carpeta vacía:** arranca las preguntas sin escribir nada antes del plano.
  - **"inicio" en una copia de la carpeta modelo de la Clase 0** (huecos `[...]` y un Excel en `originales/`): la completó, sumó `LEEME-PRIMERO.md`, `RECETA.md` y `resultados/`, y no tocó el Excel.
  - **Guía:** responde por tareas y avisa que las de Code no están instaladas.
  - **`cierre` después de trabajar:** propuso una regla y una palabra para el `CLAUDE.md`, no inventó pasos de receta y no escribió nada sin OK.
- `csv_a_excel.py` con CBU, códigos con cero adelante y con E, negativos y fechas.

### NO VERIFICADO
- **Todo en Cowork Pro:**
  - Add marketplace, Sync automatically y Upload plugin. Tampoco si Cowork necesita que suba la versión para mandar la actualización.
  - Que capataz, inicio y cierre lean `trabajos/` y `carpeta-modelo/`, y que inicio llegue al Arrancar del Capataz.
- **La pestaña Code de la app de escritorio:** los comandos `/plugin`.
- **Los nombres de menú:** Configuración > General > Instrucciones para Claude.
- **Las skills de documentos:** que vengan incluidas en Cowork.
- **La carpeta modelo de la Clase 0:** se ensayó con una copia reconstruida, porque la original está en el taller y no se pudo leer desde la nube.
- **Pendiente:**
  - La conexión al SQL una sola vez, para todos los proyectos.
  - El puente automático de `reportes` a `originales/`.
  - Revisar los mensajes de `consultar.ps1`.

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
