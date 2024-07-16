# Static Website Deployment with AWS S3, ACM, and CloudFront

This project sets up and deploys a static website on AWS using Terraform. The setup includes S3 for hosting, ACM for SSL certificates, and CloudFront for content delivery.

## Project Structure

.
├── main.tf
├── modules
│   ├── acm
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── cloudfront
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   └── s3
│       ├── index.html
│       ├── main.tf
│       ├── output.tf
│       └── variable.tf
├── output.tf
├── terraform.tfvars
└── variable.tf

## ACM DNS Validation

After applying the Terraform configuration, you need to validate the SSL certificate with ACM:

1. Go to the AWS Certificate Manager (ACM) in the N. Virginia (us-east-1) region.
2. Find the certificate that was created by Terraform.
3. Copy the CNAME records provided by ACM.
4. Add these CNAME records to your DNS provider to complete the validation.

**Note:** The SSL certification process must be performed in the N. Virginia (us-east-1) region as ACM supports SSL certification only in this region.

**Note:** Copy the CNAME records provided by cloudfront_distribution_domain_name
