# Ficha: días de pago (`fydvtsDiasPromedioDePago`)

**Una fila** = un cobro o un ajuste. **No tiene moneda** y usa `ClienteCodigo`, que a veces es una sucursal y no el titular (para pasarlo al titular, usá el par `ClienteCodigo` → `ClienteCCCodigo` de cuentas corrientes).

| Columna | Qué es |
|---|---|
| `Tipo` | `Recibo`, `Recibo preimpreso` y dos variantes de "Ajuste de cta.cte". **Filtrá `Tipo LIKE 'Recibo%'`**: los ajustes no son pagos ✅ |
| `Valores` | Importe cobrado (el peso). Está vacío en cerca del 18 % de los recibos: descartá esas filas |
| `DiasDePago` | Días que tardó ese pago |
| `ValoresPonderados` | ⚠️ **No usar**: da cerca de cero |

Historial desde 2022 ✅.

## Fórmula 📘 (últimos 12 meses)
```sql
SELECT ClienteCodigo,
       SUM(Valores * DiasDePago) / NULLIF(SUM(Valores), 0) AS DiasPromedioPago
FROM dbo.fydvtsDiasPromedioDePago
WHERE Fecha >= DATEADD(MONTH, -12, GETDATE())
  AND Tipo LIKE 'Recibo%'
  AND Valores IS NOT NULL AND DiasDePago IS NOT NULL
GROUP BY ClienteCodigo
HAVING SUM(Valores) > 0;
```
Es un promedio **ponderado por importe**: un recibo grande pesa más que uno chico.
