# Check TPM status, client executable PowerShell Script
# Depends on server.ps1
# Modify $serverAddress and $servPort to suit your needs.
# Written by Dan Weaver with Logipex LLC
# License https://creativecommons.org/licenses/by-nc/4.0/, 4/18/2024
# Contact dan@logipex.net for commercial use licensing.
function Check-TPM {
    $tpm = Get-WmiObject -Namespace "root\CIMV2\Security\MicrosoftTpm" -Class Win32_Tpm
    if ($tpm) {
        return $tpm.SpecVersion
    } else {
        return "TPM status unavailable"
    }
}

# Get client computer name
$clientName = $env:COMPUTERNAME

# Report TPM status and computer name to server
$tpmStatus = Check-TPM
$serverAddress = "192.168.0.1"
$serverPort = 10000

$client = New-Object System.Net.Sockets.TcpClient
$client.Connect($serverAddress, $serverPort)
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$writer.WriteLine("$clientName,$tpmStatus")
$writer.Close()
$client.Close()
