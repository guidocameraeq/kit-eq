# Ficha: conjuntos o kits (`fydgnrConjuntos`)

**Una fila** = un **componente** de un conjunto. El conjunto se repite por cada producto que lo compone (`ProductoCodigo`, `Cantidad`, `porcIncidencia`). ✅ Hay del orden de 13 filas por conjunto.

| Columna | Qué es |
|---|---|
| `ConjuntoCodigo`, `ConjuntoNombre` | El conjunto |
| `GrupoNombre`, `LineaNombre`, `MarcaNombre` | Clasificación |
| `fechaBaja` | Baja, si la tiene |
| `ConjuntoPrecio` | Precio del conjunto |
| `ProductoCodigo`, `ProductoNombre`, `ProductoTipo`, `Cantidad`, `porcIncidencia` | El componente |

## Cuidado
- Para un **catálogo de conjuntos**: `SELECT DISTINCT ConjuntoCodigo, ConjuntoNombre, LineaNombre ... WHERE fechaBaja IS NULL`.
- Para **ventas de conjuntos no hace falta cruzarla**: `ConjuntoCodigo` ya viene en ventas y en pedidos.
- ⚠️ **Cruzarla por `ConjuntoCodigo` duplica filas** (una por componente) y multiplica los totales. Si la cruzás, usá `DISTINCT` y compará el total con y sin el cruce.
