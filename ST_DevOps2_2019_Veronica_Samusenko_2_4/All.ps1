#1. Вывести список всех классов WMI на локальном компьютере. 

Get-WmiObject -List

#2. Получить список всех пространств имён классов WMI. 

Get-WmiObject -List "*Names*"

#3. Получить список классов работы с принтером.

Get-WmiObject -List "*Printer*"

#4. Вывести информацию об операционной системе, не менее 10 полей.

$arr = Get-WmiObject -Class "Win32_OperatingSystem" | Select-Object PSComputerName, Status, Caption, FreeSpaceInPagingFiles,`
FreeVirtualMemory, CSName, NumberOfUsers, OSArchitecture, OSLanguage, BuildNumber
Write-Output($arr)

#5. Получить информацию о BIOS.

Get-WmiObject -Class"Win32_BIOS"

#6. Вывести свободное место на локальных дисках. На каждом и сумму.

$arr = Get-WmiObject -Class "Win32_LogicalDisk" | Select-Object DeviceID, FreeSpace
[int]$sum = 0
foreach ($x in $arr)
{
    $sum += ($x.FreeSpace / 1Gb)
    
}
Write-Host("Total length = " + $sum + "Gb") -ForegroundColor "Green"

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

#8. Создать файл-сценарий вывода списка установленных программных продуктов в виде таблицы с полями Имя и Версия.

Get-WmiObject -Class "Win32_Product" | Select-Object Name, Version | Format-Table -AutoSize

#9. Выводить сообщение при каждом запуске приложения MS Word.

Register-WmiEvent -Query "Select * From __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='WINWORD.EXE'" `
-sourceIdentifier "MS WORD UP" -Action { Write-Host "Microsoft Word has been started." } 
# The event will start, when MS WORD will start.  
Register-WmiEvent -Query "Select * From __instancedeletionevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='WINWORD.EXE'" `
-sourceIdentifier "MS WORD DOWN" -Action { Write-Host "Microsoft Word has been closed." }
# The event will end, when MS WORD will close.  