# AWS Resource Listing Automation Script

## Overview
This project contains a Bash script to automate the process of listing AWS resources for a specified service and region. It supports a wide range of AWS services including EC2, RDS, S3, CloudFront, VPC, IAM, Route53, CloudWatch, CloudFormation, Lambda, SNS, SQS, DynamoDB, and EBS. The script is designed to help cloud engineers and developers quickly gather resource information without manually logging into the AWS console.

## Prerequisites
Before running the script, ensure you have the following installed and configured:

- **Bash Shell** (Linux/macOS)
- **AWS CLI** (v2 recommended)


Usage
./aws_resource_list.sh <aws_region> <aws_service>


Example:
./aws_resource_list.sh us-east-1 ec2


Supported Services:

ec2, rds, s3, cloudfront, vpc, iam, route53, cloudwatch, cloudformation, lambda, sns, sqs, dynamodb, ebs

Project Explanation

The script performs the following steps:
Argument Validation
Checks if the correct number of arguments are passed.
Validates if the requested service is supported.
Provides a help flag -h or --help.
Ensures AWS CLI is installed.
Verifies AWS CLI is properly configured using aws sts get-caller-identity.
Service-based Resource Listing
Uses case statements to handle different AWS services.
Each service query uses AWS CLI commands with --query and --output table for clean tabular output.

Examples of resources listed:

EC2: Instance IDs, types, states, public/private IPs
RDS: DB instance identifiers, engine, endpoint address/port
S3: Bucket names
Lambda: Function names and ARNs
CloudFormation: Stack names, statuses, and creation times
And others as listed above

Notes

The
Output is suitable for auditing, reporting, or CI/CD pipelines.
For extended automation, the script can be integrated with cron jobs or DevOps pipelines.