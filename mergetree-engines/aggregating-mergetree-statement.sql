-- Create a state class for aggregation
CREATE TABLE customer_behavior (
  date Date,
  customer_id UInt32,
  total_visits AggregateFunction(sum, UInt8),
  avg_session_duration AggregateFunction(avg, Float64),
  product_categories AggregateFunction(groupUniqArray, String)
) ENGINE = AggregatingMergeTree() PARTITION BY toYYYYMM(date)
ORDER BY (date, customer_id);
-- Insert data with matching types
INSERT INTO customer_behavior
SELECT date,
  customer_id,
  sumState(CAST(visits AS UInt8)),
  -- Explicitly cast to UInt8
  avgState(CAST(duration AS Float64)),
  groupUniqArrayState(category)
FROM (
    -- Sample raw data
    SELECT toDate('2024-01-01') as date,
      1 as customer_id,
      1 as visits,
      300.0 as duration,
      -- Added .0 to make it explicit Float64
      'Electronics' as category
    UNION ALL
    SELECT toDate('2024-01-01'),
      1,
      1,
      400.0,
      'Clothing'
  ) raw
GROUP BY date,
  customer_id;
-- Query aggregated results
select *
from customer_behavior;
--
SELECT date,
customer_id,
sumMerge(total_visits) as total_visits,
avgMerge(avg_session_duration) as avg_duration,
groupUniqArrayMerge(product_categories) as categories
FROM customer_behavior
GROUP BY date,
  customer_id;
--
INSERT INTO customer_behavior
SELECT date,
  customer_id,
  sumState(CAST(visits AS UInt8)),
  -- Explicitly cast to UInt8
  avgState(CAST(duration AS Float64)),
  groupUniqArrayState(category)
from (
    -- Sample raw data
    select toDate('2024-01-01') as date,
      1 as customer_id,
      1 as visits,
      450.0 as duration,
      -- Added .0 to make it explicit Float64
      'Wood' as category
  ) raw
group by date,
  customer_id