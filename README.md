# kit eQ

El **método de la carpeta** para trabajar con Claude en la oficina, listo para instalar.

> Claude se olvida de una conversación a otra. La carpeta, no.

Cada tema de trabajo vive en su carpeta, con un `CLAUDE.md` (de qué se trata y sus reglas) y un `SESSION_HANDOFF.md` (dónde quedamos). Con tres palabras, **capataz**, **inicio** y **cierre**, cualquier conversación nueva retoma donde quedó la anterior. Está pensado para gente que **no programa**: todo en criollo y sin escribir archivos a mano.

## 1. Instalarlo (una sola vez)

### En Cowork (todos)
1. En la app de Claude, abrí **Customize** (en la barra de la izquierda) y entrá a **Plugins**.
2. Tocá **Add** > **Add marketplace**, escribí `guidocameraeq/kit-eq` y confirmá.
3. En la lista aparece **kit-eq**: tocá **Install**. El otro, **kit-eq-code**, **no lo instales acá**: es solo para Code.
4. En la tienda **kit-eq**, prendé **Sync automatically**. Así las mejoras te llegan solas.
5. Para probar: abrí una conversación nueva y escribí *"¿Qué puedo hacer con el kit?"*.

Lo que instalás así queda en tu cuenta: anda en el chat, en Cowork y en Code.

### En Code (solo quien saca reportes del sistema)
En la pestaña Code, pegá estas dos líneas, de a una:
```
/plugin marketplace add guidocameraeq/kit-eq
/plugin install kit-eq-code@kit-eq
```
Queda instalado solo en esa PC. Después decí **configurar**.

### Si no te deja agregar la tienda (plan B)
Pedile el archivo `kit-eq.zip` a quien da el curso y subilo en **Customize** > **Plugins** > **Add** > **Upload plugin**. Anda igual, pero **no se actualiza solo**: cada versión nueva es un zip nuevo.

> NO VERIFICADO en cuentas Pro: los nombres exactos de los botones y que "Add marketplace" esté disponible. Si algo no coincide, avisá con una captura.

## 2. La primera vez
1. Creá una carpeta para tu primer tema de trabajo (o copiá la **carpeta modelo** del curso) y abrí Cowork con esa carpeta.
2. Escribí: **"Capataz, es mi primera vez"**.
3. El Capataz te hace unas pocas preguntas, arma la carpeta con su `CLAUDE.md` y te explica cómo seguir.

## 3. El día a día: tres palabras

| Palabra | Cuándo | Qué pasa |
|---|---|---|
| **capataz** | Tenés un tema nuevo | Te hace hasta 5 preguntas y arma la carpeta con su `CLAUDE.md` |
| **inicio** | Abrís una conversación nueva en la carpeta de un tema | Claude lee la carpeta y te cuenta dónde quedaron y qué sigue |
| **cierre** | Terminás por hoy | Claude te muestra qué va a anotar y, con tu OK, deja la carpeta al día |

Un tema por conversación. Si cambiás de tema o Claude se pone lento: **cierre** y conversación nueva.

## 4. Qué hace cada skill

| Skill | Para qué | Decí algo como... | Dónde anda |
|---|---|---|---|
| `capataz` | La bienvenida, armar o completar la carpeta de un tema, y contarte qué podés hacer | *"Capataz, armame una carpeta para la conciliación de proveedores"* | Cowork y Code |
| `inicio` | Retomar donde quedaste | *"inicio"* | Cowork y Code |
| `cierre` | Dejar anotado lo que hiciste y lo que aprendiste | *"cierre"* | Cowork y Code |
| `configurar` | Dejar la PC lista, una sola vez | *"configurar"* | Solo Code |
| `reportes` | Sacar datos del sistema a un Excel, en solo lectura | *"Sacame los saldos de septiembre en Excel"* | Solo Code, desde la oficina o con VPN |

Excel, Word, PowerPoint y PDF los hace Claude con sus skills oficiales: no hace falta instalar nada.

**Próximamente:** revisar una carpeta que ya usás, ordenar una carpeta sin borrar nada, pasar un proceso a receta y la "segunda opinión" sobre un resultado.

## 5. Actualizaciones
- Con **Sync automatically** prendido, las versiones nuevas te llegan solas. Para buscarlas a mano: Customize > Plugins > la tienda **kit-eq** > **Check for updates**.
- En Code: `/plugin marketplace update kit-eq`.
- Qué cambió en cada versión: [`CHANGELOG.md`](CHANGELOG.md).

## 6. Si algo no anda
- **No aparece el Capataz:** revisá en Customize > Plugins que **kit-eq** esté instalado y prendido, y abrí una conversación nueva.
- **Claude no retoma con "inicio":** fijate que la conversación esté abierta en la carpeta del tema.
- **Cualquier otra cosa:** avisale a quien da el curso, con una captura de pantalla.

## 7. Qué NO hace
- No borra ni pisa archivos. Los originales no se tocan: se trabaja sobre copias.
- No modifica la base de datos: `reportes` solo lee.
- No saca datos del sistema desde Cowork: Cowork corre en la nube y no llega a la red de la oficina. Eso se hace en Code.
- No trae datos de la empresa: la conexión y el catálogo de vistas son privados y nunca están en este repo.

## Para quien mantiene el kit
- Diseño y decisiones: [`docs/DISENO.md`](docs/DISENO.md).
- Cómo se trabaja (ramas, PR y versiones): [`docs/COMO-TRABAJAMOS.md`](docs/COMO-TRABAJAMOS.md).
- Antes de cada commit: `py herramientas/revisar.py`. Para el plan B: `py herramientas/empaquetar.py` (deja `dist/kit-eq.zip`).
