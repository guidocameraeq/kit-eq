# CHANGELOG — kit eQ

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
