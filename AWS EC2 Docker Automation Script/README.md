# AWS EC2 Docker Automation Script

[![Bash Script](https://img.shields.io/badge/Script-Bash-informational)](https://www.gnu.org/software/bash/)
[![AWS CLI](https://img.shields.io/badge/AWS-CLI-blue)](https://aws.amazon.com/cli/)
[![Docker](https://img.shields.io/badge/Docker-Container-blue)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

---

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
