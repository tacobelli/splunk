# Install a Universal Forwarder on Windows
Use the Powershell installer, and it must be ran as administrator or it will fail. It will wait for you to copy the local splunk admin password. Keep this in a safe place, it may be needed in the future. You'll also need to replace <your_deployment_server> with the URL of your deployment server on line 19. I'll try to keep this updated with the latest version of the forwarder as they come out. 

# Install a Universal Forwarder On Linux
Use the bash script, and it must be ran as root or it will fail. During installation, you'll be prompted to create a splunk admin user and password. I recommend using "admin" as the username and then setting the password to something random that will be kept in a safe place for potential future use. You'll also need to replace <your_deployment_server> with the URL of your deployment server on line 46.
