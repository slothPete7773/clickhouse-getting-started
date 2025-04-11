-- Inventory movements
CREATE TABLE inventory_movements (
  product_id UInt32,
  warehouse_id UInt16,
  quantity Int32,
  operation_time DateTime,
  sign Int8 -- 1 for addition, -1 for subtraction
) ENGINE = CollapsingMergeTree(sign) PRIMARY KEY (product_id)
ORDER BY (product_id, warehouse_id, operation_time);
-- Track inventory changes
INSERT INTO inventory_movements
VALUES (1, 1, 100, '2024-01-01 10:00:00', 1);
-- Received 100 units
INSERT INTO inventory_movements
VALUES (1, 1, -20, '2024-01-01 11:00:00', 1);
-- Sold 20 units
INSERT INTO inventory_movements
VALUES (1, 1, 30, '2024-01-01 11:00:00', -1);
-- Delete Sold 20 units
INSERT INTO inventory_movements
VALUES (1, 1, 50, '2024-01-01 12:00:00', 1);
INSERT INTO inventory_movements
VALUES (2, 1, 11, '2024-01-03 12:00:00', 1);
-- Received 50 more units
select *
from inventory_movements;
select sum(quantity)
from inventory_movements;
select *
from inventory_movements FINAL;
select sum(quantity)
from inventory_movements FINAL;
OPTIMIZE TABLE inventory_movements FINAL;