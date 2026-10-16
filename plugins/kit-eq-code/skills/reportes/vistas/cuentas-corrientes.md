# Ficha: cuentas corrientes (`fydvtsCtasCtes`)

**Una fila** = un documento con saldo pendiente. Cuando se salda, **desaparece**: esta vista es una **foto de hoy**, no un histórico.

| Columna | Qué es |
|---|---|
| `ImpPendiente` | **💰 Lo que falta cobrar de ese documento: LA buena.** Puede ser **negativo** (notas de crédito o pagos a cuenta sin aplicar): se netea con los positivos |
| `Importe` | Importe original del documento. ⚠️ **No es deuda** |
| `ImpAplicado` | Lo ya cobrado o aplicado |
| `Atraso` | Días de atraso. Mayor que 0 = vencido; 0 o menos, o vacío = por vencer |
| `AtrasoDetalle` | Ya trae el tramo armado (por ejemplo "Por vencer entre 0 y 30", "Vencido entre 31 y 60", "Vencido mayor a 90") ✅ |
| `Fecha`, `FechaVto` | Emisión y vencimiento |
| `NumeraTipoNombre`, `Numero` | Tipo y número del documento |
| `ClienteCCCodigo`, `ClienteCCNombre` | **Titular de la cuenta** (a quién se le cobra) |
| `ClienteCodigo`, `ClienteNombre` | **Sucursal** que originó el documento |
| `EmpresaCodigo` | **1 = Facturado, 2 = Prueba.** Son dos circuitos distintos: un total "todo" suma ambos |
| `MonedaCodigo` | Moneda. **Nunca sumar monedas distintas**: agrupá por moneda |

## Reglas 📘
- La deuda de un cliente es `SUM(ImpPendiente)` **agrupado por `ClienteCCCodigo` y `MonedaCodigo`**.
- El "atraso de la cuenta" es el del documento más atrasado **que todavía debe** (`ImpPendiente > 0`), no el `MAX(Atraso)` a secas: un crédito viejo no es deuda vencida.
- El vendedor y el cobrador de la cuenta se toman del **padrón** (`fydvtsClientes`, `Codigo = ClienteCCCodigo`), **no** del documento. El `VendedorNombre` del documento viene vacío en muchas filas.
- ⚠️ El vencido puede dar **más** que el total si la cuenta tiene créditos "por vencer". No es un error.
- ⚠️ La columna `Estado` de esta vista es la **situación del cliente** (por ejemplo `Activo Normal`, `Activo de Riesgo`, `Incobrable`, `Inactivo`), **no** el estado del documento ✅.
- Los recibos aparecen con `ImpPendiente` **negativo**: son pagos a cuenta sin aplicar ✅.
- Casi todo está en pesos; hay pocos documentos en dólares ✅.

## Ejemplo: deuda por cliente titular, separada por moneda y circuito
```sql
SELECT c.ClienteCCCodigo, c.ClienteCCNombre, c.MonedaCodigo, c.EmpresaCodigo,
       SUM(c.ImpPendiente) AS Deuda
FROM dbo.fydvtsCtasCtes c
GROUP BY c.ClienteCCCodigo, c.ClienteCCNombre, c.MonedaCodigo, c.EmpresaCodigo
HAVING SUM(c.ImpPendiente) > 0
ORDER BY Deuda DESC;
```
