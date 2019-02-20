#1.2. Получить mac-адреса всех сетевых устройств вашего компьютера.
Get-CimInstance Win32_NetworkAdapterConfiguration | Select Description, MACAddress | ? {$_.MACAddress -ne $null}
Get-WmiObject Win32_NetworkAdapterConfiguration -Credential VM2\Administrator -ComputerName VM2 | Select Description, MACAddress | ? {$_.MACAddress -ne $null}