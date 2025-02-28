# AWS Deployment Scripts

This directory contains scripts for deploying and managing the AlphaLevelin application on AWS EC2.

## Scripts

### `connect.sh`

A simple script to connect to your EC2 instance via SSH.

**Usage:**
```bash
cd aws
./connect.sh
```

### `init_server.sh`

Initializes a new EC2 instance with the AlphaLevelin application.

This script will:
1. Connect to your EC2 instance
2. Install all required dependencies
3. Clone the repository
4. Set up the database
5. Configure SSL with Let's Encrypt (if domain is configured)
6. Create a startup script

**Usage:**
```bash
cd aws
./init_server.sh
```

**Note:** Before running `init_server.sh`, update the `DOMAIN` variable in the script if you want to set up SSL with Let's Encrypt.

## Key Location

These scripts expect your EC2 key file to be located at:
```
../.creds/ec2alphalevel.pem
```

Make sure your key file has the correct permissions:
```bash
chmod 400 ../.creds/ec2alphalevel.pem
```

## Starting the Server

After running `init_server.sh`, you can start the server by:

1. Connect to your EC2 instance:
   ```bash
   ./connect.sh
   ```

2. Start the Rails server:
   ```bash
   cd alphalevelin
   ./start_server.sh
   ```

The server will run on port 443 (HTTPS) if SSL is configured, or port 3000 (HTTP) otherwise.