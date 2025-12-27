#!/bin/bash

# Define AWS EC2 instance details
aws_region="us-east-1"
instance_type="t3.micro"
ami_id="your_ami_id"
key_name="docker"
security_group_ids="sg-xxxxxxxxxxxxxxxxx"  # Specify your security group ID
subnet_id="subnet-xxxxxxxxxxxxxxxxx"        # Specify your subnet ID

# Define Docker container details
docker_image="ubuntu:latest"
docker_command="docker run -it --rm $docker_image /bin/bash"

# Function to launch an EC2 instance
launch_instance() {
    echo "Launching EC2 instance..."

    # Use AWS CLI to launch the EC2 instance
    instance_id=$(aws ec2 run-instances \
        --region "$aws_region" \
        --instance-type "$instance_type" \
        --image-id "$ami_id" \
        --key-name "$key_name" \
        --security-group-ids "$security_group_ids" \
        --subnet-id "$subnet_id" \
        --query "Instances[0].InstanceId" \
        --output text)

    # Wait for the instance to become running
    aws ec2 wait instance-running --instance-ids "$instance_id" --region "$aws_region"

    # Get the public DNS
    public_dns=$(aws ec2 describe-instances \
        --region "$aws_region" \
        --instance-ids "$instance_id" \
        --query "Reservations[0].Instances[0].PublicDnsName" \
        --output text)

    echo "Instance launched with ID: $instance_id"
    echo "Public DNS: $public_dns"
}

# Function to SSH into the EC2 instance and run Docker container
ssh_and_run_docker() {
    # Wait for the EC2 instance to become available (modify sleep time as needed)
    sleep 60

    # Get the public DNS of the EC2 instance
    public_dns=$(aws ec2 describe-instances \
        --region "$aws_region" \
        --filters "Name=instance-state-name,Values=running" "Name=key-name,Values=$key_name" \
        --query "Reservations[0].Instances[0].PublicDnsName" \
        --output text)

    echo "SSH-ing into EC2 instance..."

    # SSH into the instance and run the Docker container
    ssh -i "docker.pem" ec2-user@"$public_dns" "$docker_command"
}

# Main script workflow
main() {
    # Launch the EC2 instance
    launch_instance

    # SSH into the EC2 instance and run the Docker container
    ssh_and_run_docker
}

# Call the main function to start the script
Main
