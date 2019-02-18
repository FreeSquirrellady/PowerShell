#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 

[string]$host1 = "VM-1"
[string]$cred = "Veronica\Administrator"
Invoke-Command -ScriptBlock { Get-Service | Where-Object {$_.Status -eq "Running" }} -ComputerName $host1 -Credential $cred 