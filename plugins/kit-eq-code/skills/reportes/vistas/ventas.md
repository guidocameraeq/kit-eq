# Ficha: ventas (`fydvtsEstadisticas`) ⭐ la más importante

**Una fila** = una línea de comprobante (un artículo dentro de una factura o nota de crédito). Tiene 87 columnas: trae pegados los datos del cliente, el artículo, el vendedor y la geografía, así que muchos reportes **no necesitan cruzarla con nada**.
Datos desde enero de 2023 hasta hoy (más de 2 millones de filas) ✅. Siempre usá un rango de fechas.

## Columnas buenas
| Columna | Qué es | Notas |
|---|---|---|
| `Fecha` | Fecha del comprobante | Tiene hora: usá rango semiabierto en `AAAAMMDD` |
| `NumeraTipoTipo` | Tipo de documento | **2205 = Factura, 2206 = Nota de crédito.** Filtrá siempre por estos dos |
| `Numero` | Número del comprobante | Se repite en cada línea: `COUNT(DISTINCT Numero)` |
| `ClienteCodigo`, `ClienteNombre` | Cliente | Clave para cruzar con las demás vistas |
| `VendedorNombre` | **Vendedor de la venta** | Igualdad exacta, mayúsculas |
| `ArticuloCodigo`, `ArticuloNombre` | Artículo | `ArticuloCodigo` puede venir vacío en algunas filas |
| `ConjuntoCodigo` | Conjunto al que pertenece la línea | Ya viene acá: no hace falta cruzar con conjuntos |
| `Cantidad` | Unidades | ⚠️ ver el signo de las notas de crédito |
| `SubTotalNetoLocal` | **💰 Importe neto sin IVA en pesos: la columna de plata** | |
| `EmpresaNombre` | Circuito del comprobante (Facturado o Prueba) | Los tableros los suman juntos |

También trae sin cruzar nada: `LineaNombre`, `MarcaNombre`, `GrupoNombre` (del artículo); `ClienteCategoria` (canal), `ProvinciaNombre`, `LocalidadNombre`, `CondicionNombre`, `ListaPrecioNombre` (del cliente); `CobradorNombre`; `Periodo`.
⚠️ Los tableros de la empresa no toman de acá la línea ni la categoría del cliente: las sacan del maestro de artículos y de la cartera, que reflejan el dato de **hoy**. Las de esta vista pueden reflejar cómo estaba al facturar. ❓ no medido.

## Columnas de importe que se parecen y NO son la buena
| Columna | Por qué no |
|---|---|
| `SubTotalLocal` | Está antes del descuento del comprobante: infla |
| `SubTotalNetoReferencia`, `SubTotalReferencia` | Están en moneda de **referencia** (dólar), no en pesos |
| `Precio`, `PrecioLista` | Son unitarios, no totales |
| `impTotal` | Total **con IVA** del comprobante entero, **repetido en cada línea**. Si lo sumás directo, lo multiplicás por la cantidad de artículos. Para facturación con IVA: `MAX(impTotal)` agrupado por `Numero` y después sumá |
| `CostoFIFO*`, `UtilidadFIFOLocal`, `CostoEstandar`, `CostoActualARS` | Costos y margen. Existen, pero nadie los validó ❓ |

## Notas de crédito
- ✅ `SubTotalNetoLocal` de las notas de crédito **ya viene negativo** (casi todas). La fórmula con `-ABS` de la regla 3 es a prueba de las pocas que vienen positivas.
- ✅ En el período medido, `Cantidad` de las notas de crédito también sumaba negativo. ❓ Si vas a reportar unidades netas, verificalo antes.
- Las facturas pueden tener alguna línea negativa suelta (bonificaciones): el neto la absorbe.

## Moneda
✅ Casi todo está en pesos. Las pocas filas en dólares ya traen `SubTotalNetoLocal` **convertido a pesos**: sumar todo junto es correcto.

## Ejemplo: venta neta por vendedor en octubre de 2026
```sql
SELECT e.VendedorNombre,
       SUM(CASE WHEN e.NumeraTipoTipo = 2205 THEN e.SubTotalNetoLocal
                WHEN e.NumeraTipoTipo = 2206 THEN -ABS(e.SubTotalNetoLocal)
                ELSE 0 END)                                                       AS VentaNeta,
       COUNT(DISTINCT CASE WHEN e.NumeraTipoTipo = 2205 THEN e.Numero END)        AS Facturas,
       COUNT(DISTINCT CASE WHEN e.NumeraTipoTipo = 2205 THEN e.ClienteCodigo END) AS ClientesCompradores
FROM dbo.fydvtsEstadisticas e
WHERE e.NumeraTipoTipo IN (2205, 2206)
  AND e.Fecha >= '20261001' AND e.Fecha < '20261101'
GROUP BY e.VendedorNombre
ORDER BY VentaNeta DESC;
```
