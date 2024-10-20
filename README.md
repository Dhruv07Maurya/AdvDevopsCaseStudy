# Terraform Infrastructure Management Guide

This repository provides a comprehensive guide for managing basic infrastructure on AWS using Terraform. The guide is designed to be beginner-friendly and covers provisioning an EC2 instance and an S3 bucket, extracting the EC2 instance's IP address, and storing it in the S3 bucket.

## Table of Contents
- [Aim/Task Detail](#aimtask-detail)
- [Directory Structure](#directory-structure)
- [Steps to be Performed](#steps-to-be-performed)
- [Verification](#verification)
- [Cleanup](#cleanup)
- [Conclusion](#conclusion)

## Aim/Task Detail
This project aims to automate the management of AWS cloud resources using Terraform. Specifically, you will:
- Provision an EC2 instance.
- Create an S3 bucket.
- Extract the EC2 instance's IP address using Terraform outputs.
- Store the IP address in a text file in the S3 bucket.

## Directory Structure
The directory structure for this project is as follows:

 ├── main.tf ├── variables.tf ├── outputs.tf ├── terraform.tfstate ├── terraform.tfstate.backup └── README.md

 
## Steps to be Performed

### 1. Setup Terraform and AWS CLI
Ensure you have Terraform and AWS CLI installed and configured on your machine.

- **Install Terraform**: Follow the instructions on the [Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- **Install AWS CLI**: Follow the instructions on the [AWS CLI installation guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).
- **Configure AWS CLI**: Run `aws configure` and provide your AWS Access Key, Secret Key, region, and output format.

### 2. Define Variables
Create a `variables.tf` file to define the necessary variables such as AWS region, instance type, and bucket name.

```hcl
variable "region" {
  description = "The AWS region to deploy resources"
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  default     = "my-unique-bucket-name-123"
}

3. Write Main Configuration
Create a main.tf file to write the Terraform configuration to create the EC2 instance and S3 bucket.


provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = var.instance_type

  tags = {
    Name = "example-instance"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  tags = {
    Name = "example-bucket"
  }
}

4. Outputs Configuration
Create an outputs.tf file to configure the outputs to extract the EC2 instance's IP address.

output "instance_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}

5. Initialize Terraform
Run terraform init to initialize the project. This command downloads the necessary provider plugins and prepares the backend for state storage.

6. Apply Terraform Configuration
Run terraform apply to create the resources. Confirm the action when prompted. Terraform will show a plan of the changes it will make. Type yes to proceed.

7. Verify Outputs
After applying the configuration, Terraform will output the EC2 instance's public IP address. Note this IP address for the next step.

8. Store IP in S3
Create a local text file with the EC2 instance's IP address and upload it to the S3 bucket using the AWS CLI.

echo "EC2 Instance IP: [instance_ip]" > instance_ip.txt
aws s3 cp instance_ip.txt s3://[bucket_name]/


Replace [instance_ip] with the actual IP address and [bucket_name] with the name of your S3 bucket.

Verification
Verify EC2 Instance: Go to the AWS Management Console, navigate to the EC2 Dashboard, and verify that the instance is running.
Verify S3 Bucket: Navigate to the S3 Dashboard and check the S3 bucket for the uploaded instance_ip.txt file.
Cleanup
Destroy Resources: Run terraform destroy to clean up the created resources. Confirm the action when prompted by typing yes.
Conclusion
This project demonstrates how to use Terraform for basic infrastructure management on AWS. By following this guide, you have provisioned an EC2 instance and an S3 bucket, extracted the EC2 instance's IP address, and stored it in the S3 bucket.

References
Terraform Documentation
AWS CLI Documentation

