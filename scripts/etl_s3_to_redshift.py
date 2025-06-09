from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("ETL to Redshift") \
    .getOrCreate()

# Load CSV from S3
df = spark.read.option("header", "true").csv("s3://my-etl-data-bucket-xxxx/sample.csv")

# Write to Redshift
df.write \
  .format("jdbc") \
  .option("url", "jdbc:redshift://<redshift-endpoint>:5439/dev") \
  .option("dbtable", "public.sample_data") \
  .option("user", "awsuser") \
  .option("password", "AwsPassword123") \
  .option("driver", "com.amazon.redshift.jdbc.Driver") \
  .save()