#!/bin/bash
###################################################################################
# Script to automate the process of listing AWS resources for a given service.
# Supports: ec2, rds, s3, cloudfront, vpc, iam, route53, cloudwatch,
# cloudformation, lambda, sns, sqs, dynamodb, ebs
#
# Usage: ./aws_resource_list.sh <aws_region> <aws_service>
# Example: ./aws_resource_list.sh us-east-1 ec2
###################################################################################
# List of supported services
services=(ec2 rds s3 cloudfront vpc iam route53 cloudwatch cloudformation lambda sns sqs dynamodb ebs)

# Help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: $0 <aws_region> <aws_service>"
  echo "Example: $0 us-east-1 ec2"
  echo "Supported services: ${services[*]}"
  exit 0
fi

# Validate arguments
if [ $# -ne 2 ]; then
  echo "Error: Invalid arguments."
  echo "Usage: $0 <aws_region> <aws_service>"
  echo "Example: $0 us-east-1 ec2"
  exit 1
fi

aws_region=$1
aws_service=$2

# Validate service (it is optional)
if [[ ! " ${services[*]} " =~ " $aws_service " ]]; then
  echo "Invalid service. Supported services: ${services[*]}"
  exit 1
fi

# Check AWS CLI installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and configure it."
    exit 1
fi

# Check AWS configuration
if ! aws sts get-caller-identity &> /dev/null; then
  echo "AWS CLI is not configured properly. Please configure it."
  exit 1
fi

# List the resources based on the service
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress,PrivateIpAddress]' \
        --output table
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceClass,Engine,Endpoint.Address,Endpoint.Port]' \
        --output table
        ;;
    s3)
        echo "Listing S3 Buckets.."
        aws s3 ls --region $aws_region --query 'Buckets[*].Name' --output table
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions.."
        aws cloudfront list-distributions --region $aws_region --query 'DistributionList.Items[*].[Id,DomainName]' \
        --output table
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region --query 'Vpcs[*].[VpcId,CidrBlock]' --output table
        ;;
    iam)
        echo "Listing IAM Users.."
        aws iam list-users --region $aws_region --query 'Users[*].UserName' --output table
        ;;
    route53)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region --query 'HostedZones[*].[Id,Name]' --output table
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region --query 'MetricAlarms[*].[AlarmName,AlarmArn]' --output table
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation list-stacks --region $aws_region --query 'StackSummaries[*].[StackName,StackStatus,CreationTime]' --output table
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region --query 'Functions[*].[FunctionName,FunctionArn]' --output table
        ;;
    sns)
        echo "Listing SNS Topics.."
        aws sns list-topics --region $aws_region --query 'Topics[*].TopicArn' --output table
        ;;
    sqs)
        echo "Listing SQS Queues.."
        aws sqs list-queues --region $aws_region --query 'QueueUrls' --output table
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region --query 'TableNames' --output table
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region --query 'Volumes[*].[VolumeId,VolumeType,Size]' --output table
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac