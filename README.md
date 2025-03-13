# clickhouse-getting-started


# Clickhouse 

Clickhouse and S3 template from official example. See https://github.com/ClickHouse/examples/blob/main/docker-compose-recipes/recipes/ch-and-minio-S3/README.md

## Read file from S3 directly

```sql
SELECT * 
FROM s3('http://minio:10000/test-csv/temp.csv', -- file path in TCP interface. Not Dashboard port. Can use the Dashboard URL with TCP Port and removed '/browser' path.
        'minioadmin', -- MinIO Username
        'minioadminpassword', -- MinIO Password
        'CSVWithNames', -- Format. See https://clickhouse.com/docs/interfaces/formats 
        'id String, name String, serial String, createdAt DateTime') -- Columns and Types
LIMIT 10;
```

