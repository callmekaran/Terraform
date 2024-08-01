**Terraform Infrastructure for EC2, CloudWatch, SNS, and SSM**

**Directory Structure**
**
├── main.tf
├── modules
│   ├── cloudwatch
│   │   ├── main.tf
│   │   └── variable.tf
│   ├── ec2
│   │   ├── cloudwatch.sh
│   │   ├── data.tf
│   │   ├── main.tf
│   │   ├── my-kwy
│   │   ├── my-kwy.pub
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── sns
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   └── ssm
│       ├── locals.tf
│       └── main.tf
├── output.tf
├── provider.tf
├── terraform.tfvars
└── variable.tf**

**Modules**

1. SSM Parameter Module
This module sets up an SSM parameter to store CloudWatch Agent configuration for monitoring memory and disk utilization.

2. SNS Topic Creation Module
This module creates an SNS topic and subscribes email addresses to it for receiving alerts.

3. EC2 Instance Module
This module provisions an EC2 instance with the necessary security group, key pair, and user data for CloudWatch Agent installation.

4. CloudWatch Alarms Module
This module sets up CloudWatch alarms for CPU, memory, and disk utilization and associates them with the SNS topic for notifications.

**Prerequisites**

Terraform installed
AWS CLI configured with appropriate credentials
SSH key pair for accessing EC2 instances

**Steps**

**1 Clone the repository:**

git clone <repository-url>
cd <repository-directory>
Update variables:

Modify terraform.tfvars to specify your email addresses and other configuration values.
Modify provider.tf to set the AWS region and profile.

**2 Initialize Terraform:**

terraform init
Apply the Terraform configuration:

**3 Apply Terraform:**

terraform apply
Review the output:

Note the SNS topic ARN and EC2 instance ID from the output.

