# Terraform AWS Infrastructure Setup

This project automates the deployment of an AWS infrastructure using Terraform. It provisions a Virtual Private Cloud (VPC) with public and private subnets, security groups, an internet gateway, a NAT gateway, and additional resources like an S3 bucket and Auto Scaling Group. This README provides a detailed overview of the project, its configuration, and how to use it.

---

## **Features**

1. **VPC Setup:**
   - A VPC with a customizable CIDR block.
   - Multiple public and private subnets.

2. **Networking Components:**
   - Internet Gateway for public internet access.
   - NAT Gateway for enabling internet access for private subnets.

3. **Security Groups:**
   - Security groups for allowing specific inbound traffic.

4. **Auto Scaling and Load Balancing:**
   - Auto Scaling Group with dynamic scaling policies.
   - Application Load Balancer (ALB) for distributing traffic.

5. **Monitoring:**
   - CloudWatch Alarms for resource monitoring.
   - SNS Notifications for alerts.

6. **S3 Bucket:**
   - A secure S3 bucket with private ACL.

7. **Random ID Generator:**
   - Ensures unique naming for resources like S3 buckets.

---

## **Directory Structure**

```plaintext
.
├── main.tf       # Main Terraform configuration file.
├── variables.tf  # Variables definition file.
├── README.md     # Project documentation.
```

---

## **Prerequisites**

- **Terraform:** Install Terraform [here](https://www.terraform.io/downloads.html).
- **AWS Account:** An active AWS account with access keys.
- **IAM Permissions:** Ensure adequate permissions to create and manage AWS resources (VPC, subnets, security groups, S3, etc.).

---

## **Usage**

### 1. Clone the Repository
```bash
git clone https://github.com/Stormz99/aws-scaling-and-monitoring-terraform.git
cd aws-scaling-and-monitoring-terraform
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review and Modify Variables
Edit `variables.tf` to customize the AWS region, VPC CIDR block, subnet configuration, etc. Alternatively, update the `terraform.tfvars` file.

### 4. Validate the Configuration
```bash
terraform validate
```

### 5. Plan the Deployment
```bash
terraform plan
```

### 6. Apply the Configuration
```bash
terraform apply
```

### 7. Destroy Resources (if needed)
To delete the created resources:
```bash
terraform destroy
```

---

## **Input Variables**

The project uses the following variables, defined in `variables.tf`:

| Variable Name                  | Description                                   | Type   | Default Value            |
|--------------------------------|-----------------------------------------------|--------|--------------------------|
| `aws_region`                   | AWS region to deploy resources in            | string | `us-east-1`              |
| `vpc_name`                     | Name of the VPC                              | string | `my-vpc`                 |
| `vpc_cidr`                     | CIDR block for the VPC                       | string | `10.0.0.0/16`            |
| `private_subnets`              | Map of private subnet names to AZ indices    | map    | See `variables.tf`       |
| `public_subnets`               | Map of public subnet names to AZ indices     | map    | See `variables.tf`       |
| `ami_id`                       | AMI ID for the web server                    | string | `ami-0c55b159cbfafe1f0`  |
| `instance_type`                | Instance type for the web server             | string | `t2.micro`               |
| `variable_sub_cidr`            | CIDR block for an additional subnet          | string | `10.0.1.0/24`            |
| `environment`                  | Deployment environment (e.g., dev, prod)     | string | `test`                   |
| `asg_desired_capacity`         | Desired instances in the Auto Scaling Group  | number | `2`                      |
| `asg_max_size`                 | Max instances in the Auto Scaling Group      | number | `5`                      |
| `asg_min_size`                 | Min instances in the Auto Scaling Group      | number | `2`                      |
| `cpu_alarm_threshold`          | CPU utilization threshold for alarms         | number | `80`                     |
| `cpu_alarm_period`             | Period (in seconds) for CloudWatch alarms    | number | `300`                    |
| `cpu_alarm_evaluation_periods` | Evaluation periods for CloudWatch alarms     | number | `1`                      |
| `sns_topic_name`               | SNS Topic for notifications                  | string | `my-sns-topic`           |

---

## **Terraform Files**

### **provider.tf**
```hcl
provider "aws" {
  region = var.aws_region
}
```

### **variables.tf**
```hcl
variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = map(number)
  default = {
    "subnet-private-1" = 1
    "subnet-private-2" = 2
  }
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = map(number)
  default = {
    "subnet-public-1" = 1
    "subnet-public-2" = 2
  }
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 5
}

variable "asg_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 2
}

variable "cpu_alarm_threshold" {
  description = "The threshold for triggering the CloudWatch CPU utilization alarm"
  type        = number
  default     = 80
}

variable "cpu_alarm_period" {
  description = "The period (in seconds) for CloudWatch CPU utilization alarm"
  type        = number
  default     = 300
}

variable "cpu_alarm_evaluation_periods" {
  description = "The number of periods to evaluate for CloudWatch CPU utilization alarm"
  type        = number
  default     = 1
}

variable "sns_topic_name" {
  description = "Name of the SNS topic for CloudWatch alarm notifications"
  type        = string
  default     = "my-sns-topic"
}
```

---

## **Components Explanation**

### 1. **VPC and Subnets**
- **VPC:** A virtual network defined by `aws_vpc` resource.
- **Public Subnets:** Hosted in public AZs with internet access.
- **Private Subnets:** Isolated from the internet with NAT gateway for controlled outbound access.

### 2. **Security Groups**
- **`lb_sg`:** Allows inbound HTTP traffic on port 80.
- **`my_new_security_group`:** Allows inbound HTTPS traffic on port 443.

### 3. **Load Balancer (ALB)**
- The **Application Load Balancer (ALB)** distributes incoming HTTP traffic across the instances deployed in the public subnets. This ensures high availability and reliability for the application, scaling dynamically with the traffic demand.

### 4. **CloudWatch and SNS**
- **CloudWatch Alarms** are configured to monitor the CPU utilization of instances in the Auto Scaling Group. If CPU usage exceeds the defined threshold (80%), an alarm is triggered.
- **SNS Topic** is set up to send notifications when the CloudWatch alarm is triggered, ensuring proactive alerts for system administrators.

### 5. **S3 Bucket**
- Private S3 bucket for storing objects securely.
- Bucket ACL explicitly set to `private`.

### 6. **Random ID Resource**
- Generates a unique hexadecimal suffix for resource naming.

---


## **Contributing**

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.

---

## **License**

This project is licensed under the MIT License. See `LICENSE` for details.

---

## **Contact**

For issues or inquiries, please contact:

- **Name:** Ijiola Abiodun
- **Email:** ijiolaabiodun7@gmail.com
- **LinkedIn:** https://www.linkedin.com/in/abiodun-ijiola/

# aws-scaling-and-monitoring-terraform
