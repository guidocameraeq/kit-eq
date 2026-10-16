# Ficha: padrón de clientes (`fydvtsClientes`)

**Una fila** = un cliente. ⚠️ **La clave se llama `Codigo`** (no `ClienteCodigo`) y el nombre está en `RazonSocial` y `NombreFantasia`.

| Columna | Qué es |
|---|---|
| `Codigo` | Código de cliente (= `ClienteCodigo` de las otras vistas) |
| `RazonSocial`, `NombreFantasia` | Nombre |
| `Situacion` | Igual que `ClienteSituacion` de la cartera. Acá se escribe `Activo Normal` (con N mayúscula): compará sin importar mayúsculas |
| `fechaBaja` | Fecha de baja, si la tiene |
| `Zona` | **Zona comercial**. ⚠️ No está anidada en la provincia y hay clientes mal clasificados en la zona del interior. Normalizá con mayúsculas y sin espacios |
| `Provincia`, `Localidad` | Geografía |
| `Categoria` | Canal |
| `VendedorNombre`, `CobradorNombre` | Vendedor y cobrador de cartera |

La vista también trae datos de contacto de los clientes (mail, teléfono, domicilio, documento). Existen, pero **no los pidas si el reporte no los necesita**.

## Cómo cruzarla
`LEFT JOIN dbo.fydvtsClientes cb ON cb.Codigo = e.ClienteCodigo`. No infla el total, porque es uno a uno.

## "Activo al inicio del período" (para medir bajas) 📘
```sql
cb.Situacion = 'Activo normal'
OR (cb.Situacion = 'Inactivo' AND cb.fechaBaja >= '20261001')
```
⚠️ No hay `fechaAlta`, y hay bajas **sin** `fechaBaja`: quedan invisibles a cualquier criterio por fecha.

## Cuidado con los datos personales
Para un reporte, elegí solo las columnas necesarias. No copies datos de contacto de clientes a un chat ni los mandes por fuera de la empresa.
