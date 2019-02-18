#7. Написать сценарий, выводящий суммарное время пингования компьютера (например 10.0.0.1) в сети.

[CmdletBinding()]
Param 
(
    [parameter (Mandatory = $true, HelpMessage = "Enter ip of computer.", Position = 0)]
    [string]$ip_of_computer,

    [parameter (Position = 1)]
    [int]$times = 4
)

$sum = 0
Write-Host("Packet exchange with $ip_of_computer with 32 bytes of data:")
for ([int]$i = 0; $i -lt $times; $i++)
{
    #127.0.0.1
    $ping = Get-WmiObject -Query "select * from win32_pingstatus where Address='$ip_of_computer'" # ping host and get info
    Write-Output ("Response from $ip_of_computer" + ": value of bytes=" + $ping.BufferSize + " time=" `
    + $ping.ResponseTime + "ms TTL=" + $ping.TimeToLive)
    $sum += $ping.ResponseTime
}
Write-Host("Total time of response = $sum ms") 