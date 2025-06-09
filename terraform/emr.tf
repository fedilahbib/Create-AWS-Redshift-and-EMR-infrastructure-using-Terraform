resource "aws_security_group" "shared_sg" {
  vpc_id = aws_vpc.main.id
  name   = "shared-sg"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_emr_cluster" "emr" {
  name          = "etl-emr-cluster"
  release_label = "emr-6.15.0"
  applications  = ["Spark"]
  service_role  = aws_iam_role.emr_role.arn
  ec2_attributes {
    instance_profile = aws_iam_instance_profile.emr_instance_profile.arn
    subnet_id        = aws_subnet.private.id
    emr_managed_master_security_group = aws_security_group.shared_sg.id
    emr_managed_slave_security_group  = aws_security_group.shared_sg.id
  }

  master_instance_type = "m5.xlarge"
  core_instance_type   = "m5.xlarge"
  core_instance_count  = 2

  log_uri = "s3://${aws_s3_bucket.data_bucket.bucket}/emr-logs/"
}
