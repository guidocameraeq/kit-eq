# Ficha: pedidos (`fydvtsPedidos`)

**Una fila** = una línea de pedido (un artículo dentro de un pedido). Tiene 60 columnas. Todas las filas son del tipo de documento 2202 (pedido) ✅.

| Columna | Qué es |
|---|---|
| `Numero` | Número del pedido. Se repite por línea: `COUNT(DISTINCT Numero)` |
| `Estado` | Estado del pedido. Hay tres: `Pendiente`, `Cancelado` y `Anulado` |
| `CantidadPendiente` | **Unidades que faltan entregar: la buena** |
| `SubTotalNetoPendienteLocal` | **💰 Importe neto pendiente en pesos: la buena** |
| `ClienteCodigo`, `VendedorNombre`, `ArticuloCodigo`, `ArticuloNombre`, `ConjuntoCodigo` | Igual que en ventas |

## Qué quiere decir cada estado ⚠️
- **Pendiente:** el pedido todavía tiene cosas por entregar.
- **Cancelado:** quiere decir **completado entero**, no un pedido cancelado de verdad.
- **Anulado:** quiere decir **completado con faltantes**, no un pedido anulado.
- ⚠️ Los pedidos **Anulados siguen mostrando importe "pendiente"** ✅ (más que los Pendientes de verdad). Sin el filtro `Estado = 'Pendiente'`, el pendiente sale más del doble.

## Regla única 📘
**Pedido pendiente = `Estado = 'Pendiente' AND CantidadPendiente > 0`**, sin filtro de fecha.

## No confundir
- `Cantidad` y `SubTotalNetoPedidoLocal` son lo **pedido originalmente**, no lo pendiente.
- `CantidadAplicada` es lo ya entregado o facturado.
- Las columnas `*Referencia` están en dólares.
- ⚠️ En esta vista `EmpresaNombre` dice `Prueba` en **todas** las filas: acá no sirve para separar circuitos ❓.
- Si cruzás pedidos con ventas, el total se infla (varias filas por cliente y artículo): comparalo con y sin el cruce.

## Ejemplo: unidades e importe pendientes por vendedor
```sql
SELECT p.VendedorNombre,
       COUNT(DISTINCT p.Numero)            AS Pedidos,
       SUM(p.CantidadPendiente)            AS UnidadesPendientes,
       SUM(p.SubTotalNetoPendienteLocal)   AS ImportePendiente
FROM dbo.fydvtsPedidos p
WHERE p.Estado = 'Pendiente' AND p.CantidadPendiente > 0
GROUP BY p.VendedorNombre
ORDER BY ImportePendiente DESC;
```
