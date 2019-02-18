#6. Вывести свободное место на локальных дисках. На каждом и сумму.

$arr = Get-WmiObject -Class "Win32_LogicalDisk" | Select-Object DeviceID, FreeSpace
[int]$sum = 0
foreach ($x in $arr)
{
    $sum += ($x.FreeSpace / 1Gb)
    
}
Write-Host("Total length = " + $sum + "Gb") -ForegroundColor "Green"