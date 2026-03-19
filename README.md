#  Guía de Consultas SQL - Sistema de Pedidos

Este repositorio contiene una colección de consultas SQL diseñadas para la gestión y auditoría de una base de datos de ventas. Las consultas utilizan **subconsultas** para relacionar entidades de clientes, pedidos y productos.

##  Estructura de Consultas

### 1. Vista General de Clientes
Muestra la lista completa de todos los clientes registrados en el sistema.
```sql

##Listar clietes
SELECT * FROM Clientes;

##Relación Pedidos y Clientes
SELECT p.id AS pedido_id,
       p.fecha,
       p.total,
       (SELECT nombre FROM Clientes WHERE id = p.cliente_id) AS cliente
FROM Pedidos p
ORDER BY p.id;


##Detalle Profundo de Productos por Pedido
SELECT dp.pedido_id AS pedido_id,
       (SELECT nombre FROM Clientes WHERE id = (
           SELECT cliente_id FROM Pedidos WHERE id = dp.pedido_id
       )) AS cliente,
       (SELECT nombre FROM Productos WHERE id = dp.producto_id) AS producto,
       dp.cantidad,
       dp.subtotal
FROM Detalles_Pedido dp
ORDER BY dp.pedido_id, dp.id;

## Validación de Totales
SELECT p.id AS pedido_id,
       p.total AS total_registrado,
       COALESCE((SELECT SUM(subtotal) FROM Detalles_Pedido WHERE pedido_id = p.id), 0) AS total_calculado
FROM Pedidos p;
