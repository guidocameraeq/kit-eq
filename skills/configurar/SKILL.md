---
name: configurar
description: Deja lista la PC de un compañero para trabajar con el método de la carpeta - Python y librerías para Excel/Word/PDF, las skills oficiales de documentos, el CLAUDE.md global de Code con los principios y su puesto, la guía para pegar las instrucciones en Cowork y en el Perfil, y la carpeta Reportes con la conexión. Usar cuando dicen "configurar", "configurame la PC", "dejá todo listo" o al estrenar una PC. Corre en la pestaña Code. NO usar para arrancar un tema nuevo (eso es capataz).
---

# Configurar: dejar la PC lista (una sola vez)

Preparás la PC de un compañero que **no programa**. Le hablás en criollo, sin jerga, y le contás qué estás haciendo en una línea por paso. **Antes de cada paso que instala o escribe algo, pedís el OK.** Si un paso falla, lo anotás, seguís con el resto y al final das la lista de lo pendiente.

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

### 0. Datos de la persona (preguntá de a uno)
1. Nombre.
2. Puesto y área (por ejemplo: administración y contabilidad, RRHH).
3. Tareas habituales (3 a 5), sistemas y archivos que usa, a quién le reporta.
4. Dónde está la **carpeta compartida** del curso (la ruta la da Guido). Si no la sabe, seguí y dejá los pasos 5 y 6 pendientes.

### 1. Python
- Revisá si está: `py --version` y, si no, `python --version`.
- Si falta, con OK: `winget install -e --id Python.Python.3.12 --scope user`. Después pedí cerrar y abrir la app para que lo encuentre.
- **NO VERIFICADO:** que `winget` esté habilitado y permita instalar sin permisos de administrador en las PCs de la empresa. Si falla, anotalo como pendiente para Guido (instalar Python desde python.org, tildando "Add python.exe to PATH").

### 2. Librerías de documentos
Con OK: `py -m pip install --user openpyxl pandas python-docx python-pptx pypdf pdfplumber reportlab`.
Verificá con `py -c "import openpyxl, docx, pptx, pypdf; print('ok')"`.

### 3. Skills oficiales de documentos (Excel, Word, PowerPoint, PDF)
Son las de Anthropic (repositorio `anthropics/skills`). En Code se agregan como plugin. Pedile a la persona que pegue, de a una, en el cuadro de Code:
```
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
```
**NO VERIFICADO:** que esos nombres sigan iguales y que los comandos `/plugin` funcionen en la pestaña Code de la app de escritorio. Si no andan, anotalo como pendiente. En Cowork estas habilidades de documentos ya vienen incluidas.

### 4. CLAUDE.md global de Code
1. Leé `principios.md` (al lado de este archivo). Es la fuente única: **no lo reescribas ni lo resumas**.
2. Armá el texto: el contenido de `principios.md` **sin la nota de arriba de todo (las líneas que empiezan con `>`)**, reemplazando `[NOMBRE]` por el nombre, y completando **Mi puesto** con lo del paso 0.
3. El destino es `%USERPROFILE%\.claude\CLAUDE.md`. Si ya existe, mostrá la diferencia y preguntá: reemplazar / agregar al final / dejar como está.
4. Mostrá el texto final y escribilo solo con OK.

### 5. Instrucciones de Cowork y Perfil (lo hace la persona)
Guialo así, con el mismo texto del paso 4:
1. En la app, abrí **Configuración** (Settings) > **Cowork** > **Instrucciones globales** (Global instructions). Pegá el texto y guardá.
2. En **Configuración** > **Perfil**, en el cuadro de preferencias, pegá el mismo texto (o la parte "Cómo hablar" + "Mi puesto" si no entra).
3. En **Configuración** > **Privacidad**, apagá **"Help improve Claude"** (ayudar a mejorar Claude).
**NO VERIFICADO:** el nombre exacto de cada menú hoy (la app cambia seguido). Si no lo encuentra, que le avise a Guido; no adivines.

### 6. Carpeta Reportes (para sacar datos del SQL desde Code)
1. Creá `Documentos\Reportes\` y adentro `resultados\` y `plantillas\` (`Documentos` es la carpeta que devuelve `[Environment]::GetFolderPath('MyDocuments')`, puede estar en OneDrive).
2. Copiá **sin abrir ni mostrar su contenido** `conexion-eq.json` y `vistas.md` desde la carpeta compartida a `Reportes\`. Son privados: nunca los pegues en el chat.
3. Si no están en la carpeta compartida, dejalo pendiente para Guido.

### 7. Prueba final
1. Generá un Excel de prueba con Python en `Reportes\resultados\AAAA-MM-DD_prueba_v01.xlsx` (tres filas inventadas, una columna de importes y una fila TOTAL con fórmula `=SUM`). Si se crea y abre bien, Python y openpyxl andan.
2. Si la persona está en la oficina o con VPN, probá la red con la skill `reportes` (prueba de conexión, sin traer datos).
3. Cerrá con una tabla corta: qué quedó **listo**, qué quedó **pendiente** y para quién (la persona o Guido).
