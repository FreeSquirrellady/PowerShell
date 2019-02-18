#5.	Создать конфигурацию сессии с целью ограничения использования всех команд, кроме просмотра содержимого дисков.

[string]$cred = Get-Credential "Veronica\Administrator"
New-PSSessionConfigurationFile -Path "E:\Epam. Training\ADUser.pssc" -ModulesToImport ″ActiveDirectory″ -VisibleCmdlets *-ADUser, Get-ChildItem 
Register-PSSessionConfiguration -Name ADUser -Path  "E:\Epam. Training\ADUser.pssc" -RunAsCredential $cred -ShowSecurityDescriptorUI