# AWS Region
variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

# VPC CIDR Block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

# Environment tag for the resources
variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "production"
}

# Private Subnets
variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = map(number)
  default = {
    "subnet-private-1" = 1
    "subnet-private-2" = 2
  }
}

# Public Subnets
variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = map(number)
  default = {
    "subnet-public-1" = 1
    "subnet-public-2" = 2
  }
}

# Variable Subnet CIDR Block
variable "variable_sub_cidr" {
  description = "CIDR block for the variable subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Auto IP for the variable subnet
variable "variable_sub_auto_ip" {
  description = "Whether to automatically assign public IPs to instances in the variable subnet"
  type        = bool
  default     = true
}

# AMI ID for the instances
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Change this to your preferred AMI ID
}

# S3 Bucket Name Prefix
variable "s3_bucket_prefix" {
  description = "Prefix for the S3 bucket name"
  type        = string
  default     = "my-new-tf-s3-bucket"
}

# Instance Type for Auto Scaling Group
variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

# Desired instance count for the Auto Scaling Group
variable "asg_desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
  default     = 2
}

# Max instance count for the Auto Scaling Group
variable "asg_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 5
}

# Min instance count for the Auto Scaling Group
variable "asg_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 2
}

# CloudWatch Alarm Threshold for CPU Utilization
variable "cpu_alarm_threshold" {
  description = "The threshold for triggering the CloudWatch CPU utilization alarm"
  type        = number
  default     = 80
}

# CloudWatch Alarm Period for CPU Utilization
variable "cpu_alarm_period" {
  description = "The period (in seconds) for CloudWatch CPU utilization alarm"
  type        = number
  default     = 300
}

# CloudWatch Alarm Evaluation Periods for CPU Utilization
variable "cpu_alarm_evaluation_periods" {
  description = "The number of periods to evaluate for CloudWatch CPU utilization alarm"
  type        = number
  default     = 1
}

# SNS Topic for CloudWatch Alarm
variable "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarm notifications"
  type        = string
  default     = "my-sns-topic"
}
