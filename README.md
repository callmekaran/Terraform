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
