output "s3_bucket" {
  value = aws_s3_bucket.data_bucket.bucket
}

output "emr_cluster_id" {
  value = aws_emr_cluster.emr.id
}

output "redshift_endpoint" {
  value = aws_redshift_cluster.redshift.endpoint
}
