# 1. При помощи WMI перезагрузить все виртуальные машины.

$hosts = @("VM-1", "VM-2", "VM-3")
Invoke-Command -ScriptBlock {Restart-Computer -Force} -ComputerName $hosts -Credential "Veronica\Administrator" 