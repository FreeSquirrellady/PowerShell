#1.3. На всех виртуальных компьютерах настроить (удалённо) получение адресов с DHСP.
$names = @("VM1", "VM2", "VM3")
$cred1 = Get-Credential VM1\Administrator
$cred2 = Get-Credential VM2\Administrator
$cred3 = Get-Credential VM3\Administrator
$creds = @("$cred1", "$cred2", "$cred3") 
Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled=true" -ComputerName $names -Credential $creds | ForEach-Object -Process {$_.InvokeMethod("EnableDHCP", $null)}