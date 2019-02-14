# 6. Вывести список из 6 процессов занимающих дольше всего процессор. 
[CmdletBinding()]
Param
(
    [parameter (Mandatory = $true, HelpMessage = "Enter path to file: ")]
    [string]$path,

    [parameter (Mandatory = $true, HelpMessage = "Enter name to file: ")]
    [string]$name_of_file,

    [string]$expansion = ".txt"
)

Get-Process | Sort-Object UserProcessorTime -Descending -ErrorAction SilentlyContinue | `
Select-Object Name, Id, UserProcessorTime -First 10 > $path$name_of_file$expansion 