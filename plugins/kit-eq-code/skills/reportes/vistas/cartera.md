# Ficha: cartera (`fydvtsClientesXLinea`)

**Una fila** = un cliente. ⚠️ El nombre sugiere "una fila por cliente por línea" y documentos viejos lo afirman, pero **hoy es una por cliente** ✅ (tantas filas como clientes). Igual conviene cruzarla "a la defensiva", por si algún día cambia: con una subconsulta (`WHERE ClienteCodigo IN (SELECT ...)`) o agrupando por `ClienteCodigo`.

| Columna | Qué es | Valores |
|---|---|---|
| `ClienteCodigo`, `ClienteNombre` | Cliente | |
| `ClienteSituacion` | Situación | `Activo normal`, `Inactivo`, `Sin situacion` |
| `ClienteCategoria` | **Canal de venta** | `Mayorista`, `Minorista` |
| `VendedorNombre` | **Vendedor de cartera** (el asignado hoy) | Igualdad exacta, mayúsculas |
| `ProvinciaNombre`, `LocalidadNombre` | Geografía | |
| `ClienteLinea` | Rubro del cliente | ⚠️ trae saltos de línea pegados: limpiar con `LTRIM(RTRIM(REPLACE(REPLACE(ClienteLinea, CHAR(13), ''), CHAR(10), '')))` |

**Uso típico:** "clientes activos del vendedor X", "cartera mayorista", o cruzar con ventas para ver **quién de la cartera no compró** (los clientes dormidos son tan importantes como los activos).

## Ejemplo: clientes activos por canal
```sql
SELECT c.ClienteCategoria, COUNT(*) AS ClientesActivos
FROM dbo.fydvtsClientesXLinea c
WHERE c.ClienteSituacion = 'Activo normal'
GROUP BY c.ClienteCategoria;
```
