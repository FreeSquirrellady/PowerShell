#1.5. Удалить шару из п.1.4
(Get-WmiObject -Class Win32_Share -Credential VM2\Administrator -ComputerName VM2 -Filter "Name='TempShare'").InvokeMethod("Delete",$null)