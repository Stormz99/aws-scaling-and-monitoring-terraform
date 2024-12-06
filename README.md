# Terraform AWS Infrastructure Setup

This project automates the deployment of an AWS infrastructure using Terraform. It provisions a Virtual Private Cloud (VPC) with public and private subnets, security groups, an internet gateway, a NAT gateway, and additional resources like an S3 bucket. This README provides a detailed overview of the project, its configuration, and how to use it.

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

4. **S3 Bucket:**
   - A secure S3 bucket with private ACL.

5. **Random ID Generator:**
   - Ensures unique naming for resources like S3 buckets.

---

## **Directory Structure**

```plaintext
.
├── main.tf       # Main Terraform configuration file.
├── variables.tf  # Variables definition file.
├── outputs.tf    # Outputs definition file.
├── provider.tf   # AWS provider configuration.
├── terraform.tfvars # Variable values for the project.
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
git clone <repository-url>
cd <repository-folder>
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

| Variable Name          | Description                                   | Type   | Default Value            |
|------------------------|-----------------------------------------------|--------|--------------------------|
| `aws_region`           | AWS region to deploy resources in            | string | `us-east-1`              |
| `vpc_name`             | Name of the VPC                              | string | `demo_vpc`               |
| `vpc_cidr`             | CIDR block for the VPC                       | string | `10.0.0.0/16`            |
| `private_subnets`      | Map of private subnet names to AZ indices    | map    | See `variables.tf`       |
| `public_subnets`       | Map of public subnet names to AZ indices     | map    | See `variables.tf`       |
| `ami_id`               | AMI ID for the web server                    | string | `ami-0fb653ca2d3203ac1`  |
| `instance_type`        | Instance type for the web server             | string | `t2.micro`               |
| `variable_sub_cidr`    | CIDR block for an additional subnet          | string | `10.0.212.0/24`          |
| `variable_sub_az`      | Availability zone for the additional subnet  | string | -                        |
| `environment`          | Deployment environment (e.g., dev, prod)     | string | -                        |

---

## **Terraform Files**

### **provider.tf**
```hcl
provider "aws" {
  region = var.aws_region
}
```

### **outputs.tf**
```hcl
output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.vpc.id
}

output "private_subnets" {
  description = "IDs of the created private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "public_subnets" {
  description = "IDs of the created public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.my_new_s3_bucket.bucket
}
```

### **terraform.tfvars**
```hcl
aws_region           = "us-east-1"
vpc_name             = "demo_vpc"
vpc_cidr             = "10.0.0.0/16"
private_subnets      = {
  "private_subnet_1" = 1
  "private_subnet_2" = 2
  "private_subnet_3" = 3
}
public_subnets       = {
  "public_subnet_1" = 1
  "public_subnet_2" = 2
  "public_subnet_3" = 3
}
ami_id               = "ami-0fb653ca2d3203ac1"
instance_type        = "t2.micro"
variable_sub_cidr    = "10.0.212.0/24"
variable_sub_az      = "us-east-1a"
environment          = "dev"
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

### 3. **S3 Bucket**
- Private S3 bucket for storing objects securely.
- Bucket ACL explicitly set to `private`.

### 4. **Random ID Resource**
- Generates a unique hexadecimal suffix for resource naming.

---

## **Potential Enhancements**

1. Add a load balancer configuration.
2. Implement auto-scaling groups for high availability.
3. Enhance the security groups with stricter rules.
4. Add CloudWatch monitoring for resource logging and alerts.

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
- **Email:** [your-email@example.com]
- **LinkedIn:** [Your LinkedIn Profile]

# aws-scaling-and-monitoring-terraform
