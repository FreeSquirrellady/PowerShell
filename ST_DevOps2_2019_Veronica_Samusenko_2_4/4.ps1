#4. Вывести информацию об операционной системе, не менее 10 полей.

$arr = Get-WmiObject -Class "Win32_OperatingSystem" | Select-Object PSComputerName, Status, Caption, FreeSpaceInPagingFiles,`
FreeVirtualMemory, CSName, NumberOfUsers, OSArchitecture, OSLanguage, BuildNumber
Write-Output($arr)