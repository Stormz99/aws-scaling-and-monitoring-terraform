# AWS Region
aws_region = "us-east-1"

# VPC Configuration
vpc_cidr   = "10.0.0.0/16"
vpc_name   = "my-vpc"
environment = "testing"

# Subnets
private_subnets = {
  "subnet-private-1" = 1
  "subnet-private-2" = 2
}

public_subnets = {
  "subnet-public-1" = 1
  "subnet-public-2" = 2
}

# Variable Subnet
variable_sub_cidr   = "10.0.1.0/24"
variable_sub_auto_ip = true

# AMI ID
ami_id = "ami-0c55b159cbfafe1f0"

# Instance Type for Auto Scaling Group
instance_type = "t2.micro"

# Auto Scaling Group Configuration
asg_desired_capacity = 2
asg_max_size         = 5
asg_min_size         = 2

# CloudWatch Alarm Settings
cpu_alarm_threshold          = 80
cpu_alarm_period             = 300
cpu_alarm_evaluation_periods = 1

# SNS Topic for CloudWatch Alarm
sns_topic_name = "my-sns-topic"

# S3 Bucket Configuration
s3_bucket_prefix = "my-new-tf-s3-bucket"
