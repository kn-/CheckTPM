# CheckTPM

Client script and Listen Server to check if computers have TPM install, what version, and output to CSV file.

Usage:

Modify server.ps1 to reflect server IP and port. Be sure to open the port in your firewall!

Modify client.ps1 to reflect server IP and port for your environment.

Run server.ps1 on your server. Be sure to set your active directory as your desired output path, the csv file will output to your active directory.

Run client.ps1 on workstations or servers as needed. Most Remote Monitoring solutions support this, alternatively you can use WMIC to trigger worksations to run client.ps1. Whatever suits your management environment.

Wait for script to execute on all client computers. You can end the server.ps1 process after they have all reported in. Refer to the output csv file for results.
