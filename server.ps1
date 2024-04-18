# Check TPM status, server executable PowerShell Script
# Run this on data collection point.
# Run client.ps1 on all workstations to collect data.
# Modify server IP listen address and port as needed.
# Written by Dan Weaver with Logipex LLC
# License https://creativecommons.org/licenses/by-nc/4.0/, 4/18/2024
# Contact dan at logipex.net for commercial use licensing.
# Start listening for connections
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse("0.0.0.0"), 10000)
$listener.Start()
Write-Host "Server listening for connections..."

# Create CSV file header
$header = "ClientIP,ClientComputerName,ClientTPMStatus"

# Initialize CSV file
$header | Out-File -FilePath "tpm_logs.csv" -Encoding ascii

# Accept incoming connections
while ($true) {
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = [System.IO.StreamReader]::new($stream)
    $data = $reader.ReadLine()
    Write-Host "Received data: $data"

    # Split received data into client computer name and TPM status
    $clientInfo = $data -split ","
    $clientIP = $client.Client.RemoteEndPoint.Address
    $clientComputerName = $clientInfo[0]
    $tpmStatus = $clientInfo[1]

    # Append data to CSV file
    "$clientIP,$clientComputerName,$tpmStatus" | Out-File -FilePath "tpm_logs.csv" -Encoding ascii -Append

    $reader.Close()
    $stream.Close()
    $client.Close()
}

$listener.Stop()
