#!/bin/bash

# Script to connect to EC2 instance for AlphaLevelin project

# Configuration
EC2_DNS="ec2-65-0-180-245.ap-south-1.compute.amazonaws.com"
KEY_PATH="../.creds/ec2alphalevel.pem"
SSH_USER="ubuntu"  # User for Ubuntu instances

# Ensure key file has correct permissions
chmod 400 "$KEY_PATH"

# Display connection message
echo "Connecting to $EC2_DNS..."

# Connect using SSH
ssh -i "$KEY_PATH" "$SSH_USER@$EC2_DNS"

# If connection fails, exit with error message
if [ $? -ne 0 ]; then
    echo "Connection failed. Please check your EC2 instance status and security group settings."
    exit 1
fi