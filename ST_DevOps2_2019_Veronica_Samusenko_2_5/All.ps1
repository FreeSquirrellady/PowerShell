# 1. При помощи WMI перезагрузить все виртуальные машины.

$hosts = @("VM-1", "VM-2", "VM-3")
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName $hosts -Credential "Veronica\Administrator" 

#2.	При помощи WMI просмотреть список запущенных служб на удаленном компьютере. 

[string]$host1 = "VM-1"
[string]$cred = "Veronica\Administrator"
Invoke-Command -ScriptBlock { Get-Service | Where-Object {$_.Status -eq "Running" }} -ComputerName $host1 -Credential $cred 

#3. Настроить PowerShell Remoting, для управления всеми виртуальными машинами с хостовой.

Enter-PSSession -ComputerName "VM-1" 

# 4. Для одной из виртуальных машин установить для прослушивания порт 42658. Проверить работоспособность PS Remoting.

[string]$host1 = "VM-2"
[string]$cred = "Veronica\Administrator"
Invoke-Command -ScriptBlock {Set-Item WSMan:\localhost\listener\listener*\port -Value 42658} -ComputerName $host1 -Credential $cred


#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.

[string]$cred = Get-Credential "Veronica\Administrator"
New-PSSessionConfigurationFile -Path "E:\Epam. Training\ADUser.pssc" -ModulesToImport ″ActiveDirectory″ -VisibleCmdlets *-ADUser, Get-ChildItem 
Register-PSSessionConfiguration -Name ADUser -Path  "E:\Epam. Training\ADUser.pssc" -RunAsCredential $cred -ShowSecurityDescriptorUI
