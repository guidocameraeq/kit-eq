Versión: 2026-10-16

# Vistas del sistema: guía para armar reportes

> Solo estructura y reglas, **nunca datos**. Sale de leer la estructura real del servidor y de las reglas que ya usan los tableros de la empresa (16/10/2026).
> Marcas: ✅ medido contra el servidor · 📘 regla probada en los tableros · ⚠️ trampa conocida · ❓ sin confirmar.

## Cómo usar esta guía (para Claude)
1. Leé este índice y las **reglas de oro**.
2. Para la vista que elegiste, leé su **ficha** en la carpeta `vistas/` (al lado de este archivo). No leas las 8.
3. Solo `SELECT` sobre las vistas de esta lista. En el servidor hay otras (hasta 106) que **nadie validó**: si el pedido las necesita, preguntale a la persona y avisá que se lo cuente a Guido.
4. Escribí las vistas como `dbo.NombreDeLaVista`. La base ya la elige el archivo de conexión.

## Las 8 vistas validadas
| Vista | Para qué sirve | Una fila es | Ficha |
|---|---|---|---|
| `fydvtsEstadisticas` | **Ventas facturadas** (facturas y notas de crédito) | una línea de un comprobante | `vistas/ventas.md` |
| `fydvtsPedidos` | **Pedidos** y lo **pendiente de facturar** | una línea de un pedido | `vistas/pedidos.md` |
| `fydvtsClientesXLinea` | **Cartera**: cliente, vendedor asignado, canal, situación | un cliente | `vistas/cartera.md` |
| `fydvtsClientes` | **Padrón de clientes**: zona, provincia, baja, contacto | un cliente | `vistas/clientes.md` |
| `fydvtsCtasCtes` | **Cuentas corrientes**: lo que falta cobrar | un documento con saldo | `vistas/cuentas-corrientes.md` |
| `fydvtsDiasPromedioDePago` | **Cuántos días tarda** un cliente en pagar | un cobro o un ajuste | `vistas/dias-de-pago.md` |
| `fydgnrArticulos` | **Maestro de artículos**: línea, marca, grupo, baja | un artículo | `vistas/articulos.md` |
| `fydgnrConjuntos` | **Conjuntos** (kits) y de qué se componen | un componente de un conjunto | `vistas/conjuntos.md` |

**Cómo se cruzan:**
- Ventas (`fydvtsEstadisticas`) y Pedidos (`fydvtsPedidos`) se cruzan con el resto por `ClienteCodigo`, `ArticuloCodigo` y `ConjuntoCodigo`.
- Con el padrón (`fydvtsClientes`) se cruza por `Codigo` = `ClienteCodigo`.
- Con cuentas corrientes (`fydvtsCtasCtes`) se cruza el **titular**: `Codigo` del padrón = `ClienteCCCodigo`. No es la sucursal.
- ⚠️ **El nombre de la columna del cliente cambia según la vista:** `ClienteCodigo` en casi todas, `Codigo` en el padrón (con el nombre en `RazonSocial` / `NombreFantasia`) y `ClienteCCCodigo` (el titular) en cuentas corrientes.

## Reglas de oro
1. **Ventas = `fydvtsEstadisticas` con `NumeraTipoTipo IN (2205, 2206)`.** 2205 son facturas y 2206 notas de crédito. Sin ese filtro se cuelan otros documentos.
2. **El monto bueno es `SubTotalNetoLocal`:** neto, sin IVA, en pesos. Las demás columnas de importe se parecen y no son lo mismo.
3. **Venta neta = facturas menos notas de crédito.** La fórmula:
   ```sql
   SUM(CASE WHEN NumeraTipoTipo = 2205 THEN SubTotalNetoLocal
            WHEN NumeraTipoTipo = 2206 THEN -ABS(SubTotalNetoLocal)
            ELSE 0 END)
   ```
4. **Para contar facturas o clientes, `COUNT(DISTINCT ...)`.** Una factura tiene una fila por artículo. Contá solo las facturas (2205): si no, un cliente que tuvo solo una nota de crédito cuenta como "cliente que compró".
5. **Fechas siempre como `AAAAMMDD`, en rango semiabierto:** `Fecha >= '20261001' AND Fecha < '20261101'`. ⚠️ **Nunca con guiones** (`'2026-10-01'`): el servidor puede leerlo con el mes y el día cambiados (`'2026-09-01'` se leyó como 9 de enero). El rango semiabierto además no pierde el último día por la hora.
6. **Cliente activo = situación `Activo normal`.** En el padrón se llama `Situacion` y se escribe `Activo Normal`: compará sin importar mayúsculas. **No existe un valor "Baja"**: los dados de baja figuran como `Inactivo`.
7. **Hay dos vendedores distintos:** el **de la venta** (`fydvtsEstadisticas.VendedorNombre`, quien facturó) y el **de cartera** (el asignado hoy al cliente, en cartera y padrón). Elegí a propósito el que corresponde.
8. **Los nombres de vendedor se comparan por igualdad exacta**, en MAYÚSCULAS y sin tildes. Una variante con tilde o en minúsculas da **cero filas** y parece un error que no existe.
9. **Pedido pendiente = `Estado = 'Pendiente' AND CantidadPendiente > 0`**, sin filtro de fecha: es "lo que hay hoy".
10. **Hay dos circuitos: *Facturado* y *Prueba*.** En ventas se distinguen por `EmpresaNombre`; en cuentas corrientes, por `EmpresaCodigo` (1 = Facturado, 2 = Prueba). Los tableros de la empresa los suman juntos. Si el reporte tiene que separarlos, agrupá por esa columna y **aclaralo en el reporte**. Si no queda claro cuál quiere la persona, preguntale.
11. **Deuda = `fydvtsCtasCtes.ImpPendiente`** (no `Importe`), **separada por moneda** y por circuito.

## Antes de entregar un reporte
- [ ] ¿Filtré `NumeraTipoTipo IN (2205, 2206)` y usé `SubTotalNetoLocal` restando las notas de crédito?
- [ ] ¿Conté facturas y clientes con `DISTINCT` y solo sobre 2205?
- [ ] ¿Sumé `impTotal` directo? Está mal: se repite por línea.
- [ ] ¿Crucé con una vista de varias filas por clave (conjuntos, o pedidos y ventas entre sí) y se me infló el total? Comparar el total **con y sin** el cruce.
- [ ] ¿El vendedor es el de la venta o el de cartera? ¿Lo escribí exacto, en mayúsculas?
- [ ] ¿Las fechas van como `AAAAMMDD` y en rango semiabierto?
- [ ] En deuda: ¿`ImpPendiente`, separado por moneda y por circuito?
- [ ] ¿Incluí a los clientes de la cartera que **no** compraron, si el reporte es de cobertura?
- [ ] ¿Devolvió 0 filas? Antes de creerlo, probá que la red o la VPN esté andando: el servidor a veces devuelve vacío sin avisar.

## Las otras vistas
Existen unas 100 más (artículos, stock, compras, contabilidad, cheques, integración y pruebas). **Ninguna está validada para reportes.** No las uses sin preguntarle a la persona y sin que Guido las sume a esta guía. Familias por prefijo: `fydvts*` (ventas, clientes y cuentas corrientes), `fydgnr*` (maestros generales), `fydstk*` (stock), `fydcps*` (compras y proveedores), `fydctb*` (contabilidad), `fydfds*` (fondos y cheques), `fydcst*` y `fydpdc*` (costos y producción), `cst*` (consultas) y `AS*` (integración).

## Lo que no se sabe todavía ❓
- Costos y margen (`CostoFIFO*`, `UtilidadFIFOLocal`): existen en ventas, pero nadie los validó. No los uses.
- Qué es el tipo de documento 2207 (aparece muy poco). Queda fuera del filtro de ventas.
- El signo de `Cantidad` en las notas de crédito: en el período medido sumaba negativo. Si el reporte es de unidades netas, verificalo antes.
