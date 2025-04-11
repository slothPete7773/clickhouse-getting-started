-- Vehicle location tracking
CREATE TABLE vehicle_locations (
  vehicle_id UInt32,
  geofence_id UInt32,
  entry_time DateTime,
  version UInt32,
  sign Int8
) ENGINE = VersionedCollapsingMergeTree(sign, version)
ORDER BY (vehicle_id, geofence_id, entry_time);
-- Track vehicle movements
INSERT INTO vehicle_locations
VALUES (1, 100, '2024-01-01 10:00:00', 1, 1);
-- Enter geofence 100
INSERT INTO vehicle_locations
VALUES (1, 100, '2024-01-01 10:00:00', 1, -1);
-- Exit geofence 100
INSERT INTO vehicle_locations
VALUES (1, 103, '2024-01-01 10:00:00', 2, 1);
-- Enter geofence 103
INSERT INTO vehicle_locations
VALUES (1, 101, '2024-01-01 10:31:00', 3, 1);
-- Enter geofence 101
select *
from vehicle_locations;
select *
from vehicle_locations FINAL;