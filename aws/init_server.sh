#!/bin/bash

# Simple script to initialize AlphaLevelin server
# To use this script:
# 1. Run it from your local machine
# 2. It will SSH into your EC2 instance
# 3. Set up the server with your codebase
# 4. Configure SSL with Let's Encrypt
# 5. Start the development server on port 443

# Configuration
EC2_DNS="ec2-65-0-180-245.ap-south-1.compute.amazonaws.com"
KEY_PATH="../.creds/ec2alphalevel.pem"
SSH_USER="ubuntu"
REPO_URL="https://github.com/goforaditya/alphalevelin.git"
APP_PATH="alphalevelin"
DOMAIN="your-domain.com"  # Replace with your actual domain

# Commands to run on the server
REMOTE_COMMANDS="
echo '===== Starting AlphaLevelin server setup ====='

# Update system packages
echo '===== Updating system packages ====='
sudo apt-get update && sudo apt-get upgrade -y

# Install dependencies
echo '===== Installing dependencies ====='
sudo apt-get install -y git ruby ruby-dev build-essential libssl-dev zlib1g-dev nodejs npm

# Install Rails
echo '===== Installing Rails ====='
sudo gem install rails bundler --no-document

# Clone repository
echo '===== Cloning repository ====='
git clone $REPO_URL $APP_PATH
cd $APP_PATH

# Install application dependencies
echo '===== Installing application dependencies ====='
bundle install

# Setup database
echo '===== Setting up database ====='
bin/rails db:setup
bin/rails db:seed

# Set up Let's Encrypt (if domain is configured)
if [ '$DOMAIN' != 'your-domain.com' ]; then
  echo '===== Setting up SSL with Lets Encrypt ====='
  sudo apt-get install -y certbot
  sudo certbot certonly --standalone -d $DOMAIN --agree-tos --email your-email@example.com --non-interactive
  
  # Setup keys for Rails to use
  sudo mkdir -p config/certs
  sudo cp /etc/letsencrypt/live/$DOMAIN/fullchain.pem config/certs/
  sudo cp /etc/letsencrypt/live/$DOMAIN/privkey.pem config/certs/
  sudo chown -R ubuntu:ubuntu config/certs
fi

# Create a startup script
echo '===== Creating startup script ====='
cat > start_server.sh << 'EOF'
#!/bin/bash
cd $(dirname $0)
if [ -d config/certs ]; then
  # Start server with SSL
  sudo -E bin/rails server -b 0.0.0.0 -p 443 -e development \\
    --ssl --ssl-cert-path=config/certs/fullchain.pem \\
    --ssl-key-path=config/certs/privkey.pem
else
  # Start server without SSL
  bin/rails server -b 0.0.0.0 -p 3000 -e development
fi
EOF
chmod +x start_server.sh

echo '===== Setup complete! ====='
echo 'To start the server, run: cd $APP_PATH && ./start_server.sh'
"

# Main script execution
echo "Connecting to $EC2_DNS and setting up AlphaLevelin..."
chmod 400 "$KEY_PATH"
ssh -i "$KEY_PATH" "$SSH_USER@$EC2_DNS" "$REMOTE_COMMANDS"

echo "Server initialization complete!"
echo "SSH into your server and run: cd $APP_PATH && ./start_server.sh"