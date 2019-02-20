#1.4. Расшарить папку на компьютере
(Get-WmiObject -List -Credential VM2\Administrator -ComputerName VM2 | Where-Object -FilterScript {$_.Name -eq "Win32_Share"}).InvokeMethod("Create",("C:\Temp","TempShare",0,25,"test share"))
net share tempshare=c:\temp /users:25 /remark:"testshare of the temp folder" 