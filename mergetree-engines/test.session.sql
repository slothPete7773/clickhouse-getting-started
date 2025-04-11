-- Product catalog with version control
CREATE TABLE product_catalog (
  product_id UInt32,
  product_name String,
  price Decimal(10, 2),
  stock_quantity Int32,
  last_updated DateTime,
  version UInt32
) ENGINE = ReplacingMergeTree(version) PRIMARY KEY product_id
ORDER BY product_id;
-- Insert sample data
INSERT INTO product_catalog
VALUES (
    1,
    'Laptop',
    999.99,
    50,
    '2024-01-01 10:00:00',
    1
  );
INSERT INTO product_catalog
VALUES (
    1,
    'Laptop',
    899.99,
    45,
    '2024-01-02 10:00:00',
    2
  );
INSERT INTO product_catalog
VALUES (
    1,
    'Laptop',
    1899.99,
    45,
    '2024-01-03 10:00:00',
    3
  );
INSERT INTO product_catalog
VALUES (
    1,
    'Laptop',
    199.99,
    45,
    '2024-01-03 10:00:00',
    3
  );
INSERT INTO product_catalog
VALUES (
    2,
    'Laptop',
    199.99,
    45,
    '2024-01-03 10:00:00',
    2
  );
select *
from product_catalog;
select *
from product_catalog final;
-- After optimization, only the latest version remains
OPTIMIZE TABLE product_catalog FINAL;