Versión: 2026-10-16 · EJEMPLO

# Vistas disponibles (EJEMPLO)

> **ESTE ES UN EJEMPLO con vistas inventadas.** Guido lo reemplaza por el catálogo real antes de publicar. Solo lleva estructura: nunca datos de clientes ni importes.
> Una sección por vista: para qué sirve, columnas clave y un ejemplo de pedido en criollo.

## dbo.VistaEjemploSaldos
- **Para qué:** saldo de cuenta corriente de cada cliente.
- **Área:** administración y cobranzas.
- **Columnas clave:** `Cliente` (nombre), `Fecha` (fecha del movimiento), `Importe` (en pesos, positivo = nos deben).
- **Ojo:** las notas de crédito vienen con importe negativo.
- **Pedido de ejemplo:** "sacame los saldos de los clientes al 30/09 en Excel".

## dbo.VistaEjemploPedidos
- **Para qué:** pedidos de venta.
- **Columnas clave:** `NroPedido`, `Fecha`, `Cliente`, `Total`.
- **Pedido de ejemplo:** "pedidos de septiembre por cliente, con el total".
