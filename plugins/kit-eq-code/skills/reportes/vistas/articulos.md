# Ficha: maestro de artículos (`fydgnrArticulos`)

**Una fila** = un artículo. Se cruza por `ArticuloCodigo`.

| Columna | Qué es |
|---|---|
| `ArticuloCodigo`, `ArticuloNombre` | Artículo |
| `LineaNombre` | **Línea de producto** (el eje de los análisis de cobertura) |
| `MarcaNombre` | Origen: `Produccion propia`, `Produccion tercerizada`, `Importado`, y otros (insumos, materia prima, mano de obra, exhibidores…) |
| `GrupoNombre`, `GrupoCodigo` | Grupo |
| `EstadoBaja` | `Activo` = vigente |
| `FechaAlta`, `FechaBaja`, `DiscontinuadoOK` | Alta, baja y discontinuado |

## Catálogo comercial "de verdad" 📘
De unos 3.300 artículos, el catálogo comercial activo es aproximadamente un tercio ✅:
```sql
MarcaNombre IN ('Produccion tercerizada', 'Produccion propia', 'Importado')
AND EstadoBaja = 'Activo'
```

## Líneas que NO son líneas de producto 📘
Se sacan de los análisis de **cobertura**: `-` (sin línea), `Discontinuos`, `Muestrario`, y los **exhibidores** (mostradores, bandejas, estructuras, folios y similares). Son fixtures o ítems sueltos que inflan la cobertura. **Para totales de venta no se excluyen**: es plata que entró.
