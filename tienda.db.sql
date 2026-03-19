BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Clientes" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"correo"	TEXT NOT NULL UNIQUE,
	"telefono"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Detalles_Pedido" (
	"id"	INTEGER,
	"pedido_id"	INTEGER NOT NULL,
	"producto_id"	INTEGER NOT NULL,
	"cantidad"	INTEGER NOT NULL,
	"precio_unitario"	REAL NOT NULL,
	"subtotal"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("pedido_id") REFERENCES "Pedidos"("id") ON DELETE CASCADE,
	FOREIGN KEY("producto_id") REFERENCES "Productos"("id")
);
CREATE TABLE IF NOT EXISTS "Pedidos" (
	"id"	INTEGER,
	"cliente_id"	INTEGER NOT NULL,
	"fecha"	TEXT NOT NULL DEFAULT (datetime('now')),
	"total"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "Clientes"("id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Productos" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"precio"	REAL NOT NULL,
	"stock"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "Clientes" VALUES (1,'camilo','camilo@upb.com','3008509341');
INSERT INTO "Clientes" VALUES (2,'valeria','valeria@upb.com','3166429475');
INSERT INTO "Detalles_Pedido" VALUES (1,1,1,2,15.0,60.0);
INSERT INTO "Detalles_Pedido" VALUES (2,1,3,1,10.5,12.6);
INSERT INTO "Pedidos" VALUES (1,1,'2026-03-18',80.0);
INSERT INTO "Productos" VALUES (1,'medias',30.0,50);
INSERT INTO "Productos" VALUES (2,'Tennis adidas',50.0,10);
INSERT INTO "Productos" VALUES (3,'camisilla',25.0,10);
COMMIT;
