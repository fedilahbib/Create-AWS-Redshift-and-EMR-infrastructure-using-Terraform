resource "aws_redshift_subnet_group" "redshift_sng" {
  name       = "redshift-subnet-group"
  subnet_ids = [aws_subnet.private.id]
}

resource "aws_redshift_cluster" "redshift" {
  cluster_identifier       = "redshift-cluster"
  node_type                = "dc2.large"
  master_username          = "awsuser"
  master_password          = "AwsPassword123"
  cluster_type             = "single-node"
  publicly_accessible      = false
  vpc_security_group_ids   = [aws_security_group.shared_sg.id]
  subnet_group_name        = aws_redshift_subnet_group.redshift_sng.name
}
