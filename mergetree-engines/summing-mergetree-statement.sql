-- Daily sales metrics
CREATE TABLE daily_sales (
  date Date,
  product_id UInt32,
  total_revenue Decimal(15, 2),
  items_sold UInt32,
  return_count UInt32
) ENGINE = SummingMergeTree()
ORDER BY (date, product_id) PARTITION BY toYYYYMM(date);
-- Insert sales data
INSERT INTO daily_sales
VALUES ('2024-01-01', 1, 1000.00, 10, 1),
  ('2024-01-01', 1, 2000.00, 20, 2),
  ('2024-01-01', 2, 500.00, 5, 0);
select *
from daily_sales;
INSERT INTO daily_sales
VALUES ('2024-01-01', 1, 1000.00, 10, 1);
select *
from daily_sales;
select *
from daily_sales FINAL;
-- After optimization, sums are calculated automatically
OPTIMIZE TABLE daily_sales FINAL;