#2.4. Выключить виртуальную машину
Get-VM | where {$_.State -eq 'Running'} | Stop-VM