Key points about this implementation:

All containers are based on Alpine 3.18 (penultimate stable version)
Uses wp-cli for WordPress installation and configuration
Includes database initialization script
Self-signed SSL certificate for NGINX
All passwords and sensitive data are in environment variables
Proper volume mounting for data persistence
Container auto-restart configuration
NGINX as the only entry point on port 443
Proper permissions and security configurations

Before using this:

Replace 'login.42.fr' with your actual login
Modify the .env file with secure passwords
Add the domain to your /etc/hosts file

Would you like me to explain any specific part in more detail or would you like me to modify anything?

VM
hostname: root tmoucheIncep
localhost: inception
user: thibaud tmIncep11