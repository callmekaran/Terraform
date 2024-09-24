**Monitoring Existing EC2 Instances in Your Organization**

**Step 1: Enable Detailed Monitoring**

To start monitoring an existing EC2 instance, use the following AWS CLI command:

aws ec2 monitor-instances --instance-ids i-096ec8ba90922d2b7 --profile personal --region ap-south-1

**Step 2: Configure SSM Parameter for CloudWatch Alerts**

Utilize Terraform to set up an SSM parameter that will be used for CloudWatch alerts. (See the Terraform code below.)

**Step 3: Install SSM and CloudWatch Agent**

Use Ansible to configure and install the SSM and CloudWatch agents on your EC2 instances. You can find the playbook in the main.yml file.

**Step 4: Create SNS Topic**

Create an SNS topic and configure it to send notifications related to the specified instance ID and name.

