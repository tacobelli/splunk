#!/bin/bash
#This script installs a splunk forwarder 
#Written by Tony Iacobelli
#August 9 2019

#Make Sure we are running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

#Navigate to the temp directory
cd /tmp

#Dowload the forwarder
echo "Downloading the Forwarder"
wget -O splunkInstaller.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.3.1&product=universalforwarder&filename=splunkforwarder-7.3.1-bd63e13aa157-linux-2.6-x86_64.rpm&wget=true'

#Make sure our permissions are good
chmod 744 splunkInstaller.rpm 

#Install the forwarder
echo "Installing the Forwarder"
rpm -i splunkInstaller.rpm 

#Add the newly created splunk user to the wheel group so we can read logs
echo "Adding the Splunk user to the Wheel group so we can read logs"
usermod -aG wheel splunk

#Remove the installer
rm splunkInstaller.rpm

#Move to the splunk bin directory
cd /opt/splunkforwarder/bin

#Start splunk and accept the license
echo "Starting Splunk"
./splunk start --accept-license

#Enable splunk to start at boot
echo "Configuring Splunk to start at boot"
./splunk enable boot-start

#Point Splunk to the Deployer
echo "Pointing Splunk at the Deployment Server"
./splunk set deploy-poll <your_deployment_Server>:8089
./splunk restart
