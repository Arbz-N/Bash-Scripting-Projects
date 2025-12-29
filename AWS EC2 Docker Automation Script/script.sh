#!/bin/bash

# ================================
# AWS Configuration (Placeholders)
# ================================
aws_region="YOUR_AWS_REGION"
instance_type="YOUR_INSTANCE_TYPE"
ami_id="YOUR_AMI_ID"
key_name="YOUR_KEY_PAIR_NAME"
security_group_ids="YOUR_SECURITY_GROUP_ID"
subnet_id="YOUR_SUBNET_ID"

# ================================
# Function: Launch EC2 & SSH
# ================================
launch_instance_ssh_and_run_docker() {
    echo "Launching EC2 instance..."

    instance_id=$(aws ec2 run-instances \
        --region "$aws_region" \
        --instance-type "$instance_type" \
        --image-id "$ami_id" \
        --key-name "$key_name" \
        --security-group-ids "$security_group_ids" \
        --subnet-id "$subnet_id" \
        --query "Instances[0].InstanceId" \
        --output text)

    aws ec2 wait instance-running \
        --instance-ids "$instance_id" \
        --region "$aws_region"

    public_dns=$(aws ec2 describe-instances \
        --region "$aws_region" \
        --instance-ids "$instance_id" \
        --query "Reservations[0].Instances[0].PublicDnsName" \
        --output text)

    echo "Instance launched with ID: $instance_id"
    echo "Public DNS: $public_dns"
    echo "SSH-ing into EC2 instance..."

    ssh -i YOUR_KEY_FILE.pem \
        -o StrictHostKeyChecking=no \
        ubuntu@"$public_dns"  #change ubuntu to your username

    echo "SSH connection established."
}

# ================================
# Function Call
# ================================
launch_instance_ssh_and_run_docker
