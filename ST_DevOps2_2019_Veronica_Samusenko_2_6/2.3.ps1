#2.3. Получить состояние имеющихся виртуальных машин
Get-VM | where {$_.State -eq 'Running'}
Get-VM | where {$_.State -eq 'Off'}