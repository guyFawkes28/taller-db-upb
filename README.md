#  Guía de Consultas SQL - Sistema de Pedidos

Este repositorio contiene una colección de consultas SQL diseñadas para la gestión y auditoría de una base de datos de ventas. Las consultas utilizan **subconsultas** para relacionar entidades de clientes, pedidos y productos.


#infomracion DETALLADA DE LA BASE DE DATOS Y SUS TABLAS CON RELACIONES Y CARDINALIDAD
1. Clientes ↔ Pedidos
• Relación: "Un cliente realiza pedidos".
• Campos vinculados: Clientes.id (PK) → Pedidos.cliente_id (FK).
• Cardinalidad: 1:N (Uno a Muchos).
• Lado Cliente: Un cliente puede realizar cero o muchos pedidos (notación del círculo y la pata de gallo).
• Lado Pedido: Un pedido pertenece obligatoriamente a uno y solo un cliente (notación de las dos líneas paralelas).
2. Pedidos ↔ Detalles_Pedido
• Relación: "Un pedido contiene detalles".
• Campos vinculados: Pedidos.id (PK) → Detalles_Pedido.pedido_id (FK).
• Cardinalidad: 1:N (Uno a Muchos).
• Lado Pedido: Un pedido debe tener al menos uno o muchos detalles de pedido.
• Lado Detalles_Pedido: Cada línea de detalle pertenece obligatoriamente a un único pedido.
3. Productos ↔ Detalles_Pedido
• Relación: "Un producto es incluido en los detalles".
• Campos vinculados: Productos.id (PK) → Detalles_Pedido.producto_id (FK).
• Cardinalidad: 1:N (Uno a Muchos).
• Lado Producto: Un producto puede aparecer en cero o muchos detalles de pedido.
• Lado Detalles_Pedido: Cada detalle de pedido se refiere obligatoriamente a un único producto.

#Relaciones

TABLA: Clientes
• id: INTEGER (PK)
• nombre: TEXT
• correo: TEXT
• telefono: TEXT
TABLA: Pedidos
• id: INTEGER (PK)
• cliente_id: INTEGER (FK -> Clientes.id)
• fecha: TEXT
• total: REAL
TABLA: Productos
• id: INTEGER (PK)
• nombre: TEXT
• precio: REAL
• stock: INTEGER
TABLA: Detalles_Pedido
• id: INTEGER (PK)
• pedido_id: INTEGER (FK -> Pedidos.id)
• producto_id: INTEGER (FK -> Productos.id)
• cantidad: INTEGER
• precio_unitario: REAL
• subtotal: REAL

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
