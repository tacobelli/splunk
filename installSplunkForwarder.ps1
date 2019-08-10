#This Script Installs a Splunk Forwarder on the desiganted Host
#Written by Tony Iacobelli
#August 8th 2019
# IMPORTANT: If you are getting IE echanced security popups, add quickdraw.splunk.com and master.splunk.uc.edu as allowed sites

#Make sure we are running as Administrator
#Requires -RunAsAdministrator

#Move to the desktop directory 
$DesktopPath = [Environment]::GetFolderPath("Desktop")
cd $DesktopPath

#Download The Forwarder
Write-Host "Dowloading Splunk Forwarder"
wget "https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=windows&version=7.3.1&product=universalforwarder&filename=splunkforwarder-7.3.1-bd63e13aa157-x64-release.msi&wget=true" -OutFile splunkForwarder.msi

#Install the Forwarder
Write-Host "Installing the forwarder" 
msiexec.exe /I splunkForwarder.msi GENRANDOMPASSWORD=1 DEPLOYMENT_SERVER="<your_deployment_server>:8089" AGREETOLICENSE=Yes /quiet

#Wait 5 seconds for everything to start up 
Start-Sleep -s 5 

#Get the random password that splunk created 
Write-Host "Below is the local password to administer Splunk. Save this password in a safe place, as it may be needed in the future:" -ForegroundColor white -BackgroundColor red 
Select-String -Path $env:TEMP\splunk.log -Pattern 'PASSWORD='

#Give the user time to write down the password
Read-Host -Prompt "Press enter once the password has been written down"

#Remove the temp file so that the password is not lingering there
Write-Host "Removing password from log file on local system" 
Remove-Item $env:TEMP\splunk.log
Write-Host "File Removed"

#Remove the MSI Installer
Write-Host "Removing the MSI Installer"
Remove-Item $DesktopPath\splunkForwarder.msi

#Check that splunk is running
Write-Host "Checking that splunk is running, and starting it if it's not running"
& 'C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe' start
