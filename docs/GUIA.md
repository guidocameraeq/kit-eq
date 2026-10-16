# Guía de uso del kit eQ

Para quien trabaja en la oficina y **no programa**. Si es tu primera vez, leé las secciones 1 a 4 en orden; el resto lo consultás cuando lo necesites.

**Contenido**
1. [Antes de empezar](#1-antes-de-empezar)
2. [Instalar el kit](#2-instalar-el-kit)
3. [La primera vez](#3-la-primera-vez)
4. [El día a día](#4-el-día-a-día)
5. [Para que Claude rinda: conversaciones cortas y una carpeta al día](#5-para-que-claude-rinda-conversaciones-cortas-y-una-carpeta-al-día)
6. [Qué hace cada skill](#6-qué-hace-cada-skill)
7. [Las recetas: tareas que se repiten](#7-las-recetas-tareas-que-se-repiten)
8. [Datos del sistema](#8-datos-del-sistema)
9. [Actualizaciones](#9-actualizaciones)
10. [Si algo no anda](#10-si-algo-no-anda)
11. [Palabras que vas a escuchar](#11-palabras-que-vas-a-escuchar)

---

## 1. Antes de empezar

Necesitás:
- **Una cuenta de Claude Pro** y la **app de Claude para escritorio** con la sesión iniciada.
- **Tus instrucciones pegadas en Claude.** Son el texto con los principios y tu puesto que se pegó en la Clase 0, en **Settings** (Configuración) > **General** > **Instructions for Claude** (Instrucciones para Claude). Con eso Claude ya sabe quién sos y no te lo vuelve a preguntar. Si no lo tenés, pedíselo a quien da el curso.
- **Una carpeta madre para tus temas**, por ejemplo `Documentos\Claude\`. Adentro va una carpeta por tema.

> Los menús figuran como aparecen hoy en la app, en inglés, con la traducción entre paréntesis. Pueden cambiar, porque la app se actualiza seguido. Si no encontrás algo, avisá con una captura de pantalla.

## 2. Instalar el kit

Se hace **una sola vez**. Lo que instalás queda en tu cuenta y anda en el chat, en Cowork y en Code.

### En Cowork (todos)
1. En la app, abrí **Customize** en la barra de la izquierda y entrá a **Plugins**.
2. Tocá **Add** > **Add marketplace**.
3. Escribí `guidocameraeq/kit-eq` y confirmá.
4. En la lista aparecen dos paquetes. Instalá **kit-eq** con **Install**.
   - **No instales `kit-eq-code` acá:** es solo para la pestaña Code.
5. En la tienda **kit-eq**, prendé **Sync automatically**. Así las mejoras te llegan solas.
6. Para probar, abrí una conversación nueva y escribí *"¿Qué puedo hacer con el kit?"*.

> **Si en la Clase 0 subiste skills sueltas** (capataz, inicio o cierre) en **Customize** > **Skills**, borralas antes de instalar el kit, para que no haya dos de cada una.

### Si no te deja agregar la tienda (plan B)
1. Pedile el zip del kit (por ejemplo `kit-eq-0.2.1.zip`) a quien da el curso. Si está publicado, también lo podés bajar de [Releases](https://github.com/guidocameraeq/kit-eq/releases).
2. Subilo en **Customize** > **Plugins** > **Add** > **Upload plugin**.

Anda igual, pero **no se actualiza solo**: para cada versión nueva, borrá el paquete viejo en **Customize** > **Plugins** y subí el zip nuevo.

### En Code (solo quien saca datos del sistema)
1. Abrí la pestaña **Code** en cualquier carpeta de trabajo.
2. Pegá estas dos líneas, de a una:
   ```
   /plugin marketplace add guidocameraeq/kit-eq
   /plugin install kit-eq-code@kit-eq
   ```
3. Cerrá y volvé a abrir la sesión de Code, y decí **configurar**. Te va a pedir la ruta de la carpeta compartida del curso: tenela a mano.

Lo que instalás desde Code queda **solo en esa PC**.

## 3. La primera vez

1. Creá una **carpeta vacía** para tu primer tema dentro de tu carpeta madre. Por ejemplo, `Documentos\Claude\Conciliacion-bancaria`, con un nombre corto y sin tildes.
2. Abrí una conversación nueva. Abajo, en el cuadro donde se escribe, tocá el **+** y elegí esa carpeta.
3. Escribí: **"Capataz, es mi primera vez"**.

El Capataz:
1. Te explica el método en cinco líneas.
2. Te hace **hasta 5 preguntas, de a una**: de qué se trata, cada cuánto se hace, con qué archivos trabajás, qué tiene que salir y para quién, y si ya tenés archivos.
3. Te muestra **el plano** de lo que va a crear y **espera tu OK**.
4. Arma la carpeta y te dice cómo seguir.

**¿Ya tenés una copia de la carpeta modelo del curso?** Abrila en Cowork y decí **inicio**: el Capataz ve qué falta, completa los huecos y suma lo que no está, sin pisar lo que escribiste.

> **Dejá la app abierta mientras Claude trabaja.** Cowork corre en la nube y llega a tu carpeta a través de la app.

## 4. El día a día

| Paso | Qué hacés | Qué hace Claude |
|---|---|---|
| 1 | Abrís una **conversación nueva** con la carpeta del tema y decís **inicio** | Lee la carpeta y te cuenta en 3 líneas: dónde quedaron, qué sigue y con qué tener cuidado |
| 2 | Trabajás el tema en criollo: *"Armame el resumen por proveedor de septiembre"* | Te propone un plan corto, espera tu OK, trabaja sobre las copias de `originales/` y deja lo que arma en `resultados/` |
| 3 | Revisás: *"Mostrame 3 números y de qué archivo salen"* | Te los muestra contra el archivo original |
| 4 | Decís **cierre** | Te muestra un borrador de lo que va a anotar y, con tu OK, deja la carpeta al día |

Para la próxima: conversación nueva y **inicio**. No hace falta explicar nada de nuevo.

## 5. Para que Claude rinda: conversaciones cortas y una carpeta al día

Claude trabaja mejor con conversaciones **cortas y de un solo tema**. Cuando una conversación se hace muy larga, se pone lento y empieza a resumir lo que habló, y ahí se pierden detalles. El kit está armado para evitarlo:

- **Un tema, una conversación.** Si aparece otro tema: **cierre** y conversación nueva en la carpeta de ese tema.
- **Cerrá seguido.** Al terminar una parte importante, o si notás que Claude está lento: **cierre**, conversación nueva e **inicio**. Lo importante ya quedó en la carpeta.
- **La memoria está en la carpeta, no en la conversación.** El `CLAUDE.md` guarda las reglas del tema, el `SESSION_HANDOFF.md` dónde quedaron y el `CHANGELOG.md` la historia.
- **El `CLAUDE.md` mejora con el uso.** Si en la charla aparece una regla ("las notas de crédito restan") o una sigla ("ND = nota de débito"), el **cierre** propone anotarla. También podés pedirlo directo: *"Anotá en el CLAUDE.md que las comisiones no son diferencias"*. Claude lo anota tal cual y te muestra la línea.
- **Pedí el plan antes.** Para algo grande, Claude cuenta qué va a hacer y espera tu OK.
- **Verificá siempre 3 números** contra el original antes de usar un resultado.

## 6. Qué hace cada skill

Una *skill* es una habilidad que se le suma a Claude. Las tres palabras (**capataz**, **inicio** y **cierre**) conviene decirlas tal cual; para lo demás alcanza con decir lo que necesitás, y Claude elige la skill que corresponde.

### capataz: el jefe de obra
Prepara todo para que se trabaje bien, pero no hace el trabajo del tema.
- **Bienvenida:** *"Capataz, es mi primera vez"*.
- **Armar o completar una carpeta:** *"Capataz, tengo un tema nuevo: las facturas de proveedores"* o *"Capataz, completá el CLAUDE.md"*.
- **Guía:** *"¿Qué puedo hacer con el kit?"*.

### inicio: retomar
*"inicio"*, en una conversación nueva abierta en la carpeta del tema.
- Te cuenta dónde quedaron y qué sigue.
- Si hay una receta con pasos, te ofrece correrla paso a paso, con un control en cada paso.
- Si la carpeta está vacía o a medio armar, la arma con vos.

### cierre: dejar anotado
*"cierre"*, al terminar.
- Te muestra un borrador: qué hicieron, qué sigue, qué no funcionó y qué quedó pendiente.
- Propone las reglas y palabras nuevas para el `CLAUDE.md` y los cambios de la receta.
- Escribe recién cuando decís que sí. Podés aceptar una parte: *"sí, menos la receta"*.
- Ojo: si hablás del **cierre de mes** o del **cierre de caja**, Claude entiende que es parte del trabajo y no termina la conversación. Si hay duda, te pregunta si querés cerrar.

### configurar (solo Code)
Deja la PC lista una sola vez: Python, las librerías para Excel, Word y PDF, tus instrucciones y la carpeta de reportes.

### reportes (solo Code)
*"Sacame los saldos de septiembre en Excel"*. Consulta las vistas del sistema **en solo lectura** y entrega un Excel con totales por fórmula y una hoja de control. Anda desde la oficina o con la VPN prendida.

## 7. Las recetas: tareas que se repiten

Si un tema se hace cada semana o cada mes, el Capataz le suma una `RECETA.md`.
1. **La primera vez** lo hacen juntos, y al **cierre** Claude propone los pasos, cada uno con su control (cómo se sabe que salió bien).
2. **Las veces siguientes**, con **inicio** Claude ofrece correr la receta paso a paso. Si un control falla, **para y avisa**.
3. **Si algo cambia** (un paso nuevo, una excepción), el **cierre** propone actualizar la receta, y la actualiza solo con tu OK.

Así el trabajo sale igual todos los meses, lo haga quien lo haga.

## 8. Datos del sistema

**Cowork no llega a la base de datos de la oficina**, porque corre en la nube. Los datos se sacan en Code y se trabajan en Cowork:
1. Abrí la pestaña **Code** en la carpeta `Documentos\Reportes` y pedí el reporte: *"Sacame las compras de septiembre en Excel"*.
2. El Excel queda en `Documentos\Reportes\resultados\`. **Copialo** (no lo muevas) a `originales/` de la carpeta del tema.
3. En **Cowork**, con **inicio**, seguís trabajando con ese Excel.

## 9. Actualizaciones

**Cómo funciona:** cuando Guido mejora el kit, sube el número de versión. Quien tiene el kit instalado recibe el cambio **solo si cambió ese número**. Por eso no te llega nada a medio hacer.

- **Cowork y el chat** (kit-eq): con **Sync automatically** prendido, las versiones nuevas llegan solas. Para buscarlas a mano: **Customize** > **Plugins** > la tienda **kit-eq** > **Check for updates**.
- **Code:** lo que instalaste en **Customize** > **Plugins** también llega a Code solo, desde tu cuenta. Para `kit-eq-code` (configurar y reportes) hay que prender una vez la actualización automática: `/plugin` > pestaña **Marketplaces** > **kit-eq** > **Enable auto-update**. Para buscar a mano: `/plugin marketplace update kit-eq` y después **Update now** en `/plugin` > **Installed**. Cerrá y abrí la sesión para que la tome.
- **Si lo instalaste con el zip:** no se actualiza solo. Pedí el zip nuevo, borrá el paquete viejo y subí el nuevo.
- **Qué cambió en cada versión:** [CHANGELOG](../CHANGELOG.md).

> En Cowork, cómo se comporta **Sync automatically** es NO VERIFICADO: se prueba con la primera actualización real.

## 10. Si algo no anda

| Pasa esto | Probá esto |
|---|---|
| No aparece el Capataz | En **Customize** > **Plugins**, revisá que **kit-eq** esté instalado y prendido. Abrí una conversación nueva |
| Claude no retoma con **inicio** | Fijate que la conversación esté abierta con la carpeta del tema, no con la carpeta madre |
| Claude no ve tus archivos | Pegá las copias adentro de la carpeta del tema, en `originales/`. Cowork solo ve la carpeta que conectaste |
| Claude está lento o se olvida de cosas | **cierre**, conversación nueva e **inicio** |
| Te pregunta cosas que ya sabe | Revisá que tus instrucciones estén pegadas (sección 1) |
| Hay dos Capataz o dos inicio | Borrá las skills sueltas viejas en **Customize** > **Skills** |
| Me olvidé de decir **cierre** | Volvé a esa conversación y decí **cierre**. Si no la encontrás, en una nueva decí **inicio** y contale en una línea lo que hiciste |
| Claude me pide permiso para algo | Si es leer o escribir en la carpeta del tema, aceptá. Si es otra cosa o no entendés, decí que no y preguntale |
| Otra cosa | Avisale a quien da el curso, con una captura de pantalla |

## 11. Palabras que vas a escuchar

| Palabra | Qué es |
|---|---|
| **Cowork** | La parte de Claude que trabaja con los archivos de una carpeta de tu PC |
| **Code** | La pestaña de Claude para tareas técnicas, como sacar datos del sistema |
| **Skill** | Una habilidad que se le suma a Claude: capataz, inicio, cierre... |
| **Plugin** o **paquete** | Un conjunto de skills que se instala junto. El kit son dos paquetes: `kit-eq` y `kit-eq-code` |
| **Tienda** (*marketplace*) | El lugar de donde se instala el kit: este repositorio |
| **Carpeta modelo** | Cómo tiene que quedar la carpeta de cada tema. El Capataz la conoce y la arma |
| **`CLAUDE.md`** | La ficha del tema: de qué se trata, reglas y palabras |
| **`SESSION_HANDOFF.md`** | La nota de "dónde quedamos" para la próxima conversación |
| **Receta** | Los pasos de una tarea que se repite, con un control en cada paso |
