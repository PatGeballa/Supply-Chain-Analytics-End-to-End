SELECT * FROM Inventory_Snapshots
SELECT * FROM products
SELECT * FROM Purchase_Orders
SELECT * FROM warehouses
SELECT * FROM suppliers 


----- DELETE Duplicates FROM Warehouses----

WITH duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY warehouse_id
               ORDER BY warehouse_id
           ) AS rn
    FROM warehouses
)
DELETE FROM duplicates
WHERE rn > 1;


---- DELETE Duplicates From Suppliers ---
WITH duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY supplier_id
               ORDER BY supplier_id
           ) AS rn
    FROM Suppliers
)
DELETE FROM duplicates
WHERE rn > 1;


---- Inventory Snapshots Remove Duplicates -----

WITH duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY snapshot_date, warehouse_id, product_id
               ORDER BY snapshot_date
           ) AS rn
    FROM Inventory_Snapshots
)
DELETE FROM duplicates
WHERE rn > 1;


