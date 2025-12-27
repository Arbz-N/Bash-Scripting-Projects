# AWS EC2 Docker Automation Script

## Overview
This project provides a **Bash script** to automate the deployment of an AWS EC2 instance and launch a Docker container on it. It allows developers and DevOps engineers to quickly spin up an EC2 instance, SSH into it, and run any Docker image without manually performing the steps.

---

## Prerequisites
Before running the script, ensure the following are installed and configured:

- **Bash Shell** (Linux/macOS)
- **AWS CLI (v2 recommended)**  
- **Docker installed on EC2 instance**
- **AWS credentials** properly configured via:
```bash
aws configure
