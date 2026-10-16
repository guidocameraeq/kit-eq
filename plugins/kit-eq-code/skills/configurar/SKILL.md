---
name: configurar
description: Deja lista la PC de un compañero para trabajar con el método de la carpeta - Python y librerías para Excel/Word/PDF, las skills oficiales de documentos, el CLAUDE.md global de Code con los principios y su puesto, la guía para pegar las instrucciones en Claude (también valen para Cowork), y la carpeta Reportes con la conexión. Usar cuando dicen "configurar", "configurame la PC", "dejá todo listo" o al estrenar una PC. Corre en la pestaña Code. NO usar para arrancar un tema nuevo (eso es capataz).
---

# Configurar: dejar la PC lista (una sola vez)

Preparás la PC de un compañero que **no programa**. Le hablás de vos, en español rioplatense (nunca "tú"), en criollo, sin jerga, y le contás qué estás haciendo en una línea por paso. **Antes de cada paso que instala o escribe algo, pedís el OK.** Si un paso falla, lo anotás, seguís con el resto y al final das la lista de lo pendiente.

## Dónde anda

- **Pestaña Code** de la app de escritorio, en la PC (instala cosas y escribe archivos locales).
- **NO en Cowork:** Cowork corre en la nube y no puede instalar nada en la PC. Si te invocan desde Cowork, pedí que abran la pestaña Code.
- **Lo que no podés hacer vos:** tocar la configuración de la app (Perfil, instrucciones de Cowork, privacidad). Eso lo hace la persona con tu guía, paso a paso.

## Lo que NO hace

- No borra ni mueve archivos del usuario.
- No pisa un CLAUDE.md global que ya exista: muestra la diferencia y pregunta.
- No guarda claves en ningún lado nuevo: solo copia `conexion-eq.json` tal cual de la carpeta compartida a la carpeta Reportes.
- No cambia configuraciones de Windows ni de seguridad.

## Pasos

### 0. Datos de la persona
Si ya están en sus instrucciones (el bloque **Mi puesto**), confirmalos en una línea y preguntá solo lo que falte, de a uno:
1. Nombre.
2. Puesto y área (por ejemplo: administración y contabilidad, RRHH).
3. Tareas habituales (3 a 5), sistemas y archivos que usa, a quién le reporta.
4. Dónde está la **carpeta compartida** del curso (la ruta la da Guido). Si no la sabe, seguí y dejá el paso 6 pendiente.

### 1. Python
- Revisá si está: `py --version` y, si no, `python --version`.
- Si falta, con OK: `winget install -e --id Python.Python.3.12 --scope user --silent --accept-package-agreements --accept-source-agreements`. Antes de correrlo, contale en una línea que eso acepta las condiciones de uso de Python y del instalador de Windows; con su OK lo corrés (sin esas dos opciones `winget` se queda esperando una respuesta que acá no se puede dar). Después pedí cerrar y abrir la app para que lo encuentre.
- **NO VERIFICADO:** que `winget` esté habilitado y permita instalar sin permisos de administrador en las PCs de la empresa, y que deje el comando `py` (si solo aparece `python`, usá ese en los pasos siguientes). Si falla o aparece un cartel pidiendo permiso de administrador, no insistas: anotalo como pendiente para Guido (instalar Python desde python.org, tildando "Add python.exe to PATH").

### 2. Librerías de documentos
Con OK: `py -m pip install --user openpyxl pandas python-docx python-pptx pypdf pdfplumber reportlab` (si en el paso 1 anduvo `python` y no `py`, usá `python -m pip ...`).
Verificá con `py -c "import openpyxl, docx, pptx, pypdf; print('ok')"`.
**NO VERIFICADO:** que la red de la empresa deje bajar librerías (si da error de conexión o de certificado, anotalo como pendiente para Guido; no desactives controles de seguridad).

### 3. Mantener el kit al día (Code)
En Code las tiendas de terceros **no se actualizan solas**: hay que prender la actualización automática una vez. Guialo así, con OK en cada paso:
1. **El Capataz, inicio y cierre (`kit-eq`) no se instalan acá.** Si lo instaló en Customize > Plugins, ya llega a Code solo, desde la cuenta (aparece como `kit-eq@synced`). Si no está, avisale que primero lo instale en Customize > Plugins (guía: sección 1 de `docs/GUIA.md`).
2. Pedile que pegue en el cuadro de Code, si la tienda todavía no está: `/plugin marketplace add guidocameraeq/kit-eq`.
3. Instalá `kit-eq-code` con: `/plugin install kit-eq-code@kit-eq`.
4. Prendé la actualización automática: `/plugin` > pestaña **Marketplaces** > **kit-eq** > **Enable auto-update**.
5. Para buscar una versión nueva a mano: `/plugin marketplace update kit-eq`, y después en `/plugin` > **Installed** > **kit-eq-code** > **Update now**.
Según la documentación oficial de Claude Code, la tienda de un tercero viene con la actualización automática apagada y un plugin recibe cambios solo cuando sube su `version`. **NO VERIFICADO:** que estos menús sean iguales en la pestaña Code de la app de escritorio (ahí figuran en **+** > **Plugins** > **Manage plugins**). Si no los encuentra, anotalo como pendiente para Guido.

### 3. Skills oficiales de documentos (Excel, Word, PowerPoint, PDF)
Son las de Anthropic (repositorio `anthropics/skills`). En Code se agregan como plugin. Pedile a la persona que pegue, de a una, en el cuadro de Code:
```
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
```
Los nombres se probaron el 07/10/2026 con la línea de comandos de Claude Code (`claude plugin marketplace add anthropics/skills` y `claude plugin install document-skills@anthropic-agent-skills` instalaron Excel, Word, PowerPoint y PDF). **NO VERIFICADO:** que los comandos `/plugin` pegados en la pestaña Code de la app de escritorio hagan lo mismo. Si no andan, anotalo como pendiente. **NO VERIFICADO:** que en Cowork estas habilidades de documentos ya vengan incluidas.

### 4. CLAUDE.md global de Code
1. Leé `principios.md` (al lado de este archivo). Es la fuente única: **no lo reescribas ni lo resumas**.
2. Armá el texto: el contenido de `principios.md` **sin la nota de arriba de todo (las líneas que empiezan con `>`)**, reemplazando `[NOMBRE]` por el nombre, y completando **Mi puesto** con lo del paso 0.
3. El destino es `%USERPROFILE%\.claude\CLAUDE.md`. Si ya existe, mostrá la diferencia y preguntá: reemplazar / agregar al final / dejar como está.
4. Mostrá el texto final y escribilo solo con OK.

### 5. Instrucciones de Claude (lo hace la persona)
En la app nueva, el chat y Cowork comparten **un solo lugar** para las instrucciones. Guialo así, con el mismo texto del paso 4:
1. En la app, abrí **Configuración** (Settings) > **General** > **Instrucciones para Claude** (Instructions for Claude). Pegá el texto y guardá. Va **una sola vez**: no lo pegues en dos lugares.
2. Si ya había un texto de la Clase 0, mostrá la diferencia y preguntá: reemplazar / dejar como está.
3. En **Configuración** > **Privacidad**, apagá **"Help improve Claude for everyone"** (ayudar a mejorar Claude).
**NO VERIFICADO:** el nombre exacto de cada menú hoy (la app cambia seguido). Si no lo encuentra, que le avise a Guido; no adivines.

### 6. Carpeta Reportes (para sacar datos del SQL desde Code)
1. Creá `Documentos\Reportes\` y adentro `resultados\` y `plantillas\` (`Documentos` es la carpeta que devuelve `[Environment]::GetFolderPath('MyDocuments')`, puede estar en OneDrive).
2. Copiá **sin abrir ni mostrar su contenido** `conexion-eq.json` y `vistas.md` desde la carpeta compartida a `Reportes\`. Son privados: nunca los pegues en el chat.
3. Si no están en la carpeta compartida, dejalo pendiente para Guido.

### 7. Prueba final
1. Generá un Excel de prueba con Python en `Reportes\resultados\AAAA-MM-DD_prueba_v01.xlsx` (tres filas inventadas, una columna de importes y una fila TOTAL con fórmula `=SUM`). Pedile a la persona que lo abra con doble clic y te diga qué total ve; si coincide con la suma de las tres filas, Python y openpyxl andan.
2. Si la persona está en la oficina o con VPN, probá la red con la skill `reportes` (prueba de conexión, sin traer datos). **NO VERIFICADO:** que las PCs de la empresa dejen correr el script con `-ExecutionPolicy Bypass` (si una política de la empresa lo bloquea, aparece un error de "ejecución de scripts deshabilitada": pendiente para Guido, no cambies la política).
3. Cerrá con una tabla corta: qué quedó **listo**, qué quedó **pendiente** y para quién (la persona o Guido).
