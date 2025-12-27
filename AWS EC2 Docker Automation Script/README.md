# AWS EC2 Launch & SSH Automation Script

## Overview
This project automates the process of launching an **AWS EC2 instance**, waiting for it to become available, retrieving its **public DNS**, and then **SSH-ing into the instance automatically**.

The script is useful for DevOps engineers and cloud learners who want to quickly spin up EC2 instances for testing, Docker setup, or hands-on practice without manually using the AWS Console.

---

## Prerequisites
Before running this script, ensure the following requirements are met:

- **Linux / macOS environment**
- **Bash shell**
- **AWS CLI (v2 recommended)**
- **Configured AWS credentials**
- **SSH key pair available locally**

Configuration Variables

The following variables are defined at the top of the script and should be updated according to your AWS environment:

aws_region="YOUR_AWS_REGION"
instance_type="YOUR_INSTANCE_TYPE"
ami_id="YOUR_AMI_ID"
key_name="YOUR_KEY_PAIR_NAME"
security_group_ids="YOUR_SECURITY_GROUP_ID"
subnet_id="YOUR_SUBNET_ID"

How the Script Works (Project Explanation)
1. Launch EC2 Instance

The script uses the AWS CLI run-instances command to create a new EC2 instance using the provided configuration.

Key parameters:

    AMI ID
    Instance type
    Key pair
    Security group
    Subnet

The Instance ID is captured dynamically for later use.

2. Wait for Instance to Become Ready

After launching, the script waits until the EC2 instance reaches the running state using:
aws ec2 wait instance-running
This ensures the instance is fully ready before proceeding.

3. Fetch Public DNS

Once the instance is running, the script retrieves the Public DNS name, which is required for SSH access.

4. SSH into the EC2 Instance

The script automatically connects to the instance using SSH:

ssh -i docker.pem ubuntu@<PUBLIC_DNS>
SSH host key checking is disabled for automation.
Default Ubuntu user is used.

Usage

    Make the script executable:
    chmod +x ec2_launch_ssh.sh
    
    Run the script:
    ./ec2_launch_ssh.sh
