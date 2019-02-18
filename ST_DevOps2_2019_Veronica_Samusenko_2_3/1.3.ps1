#1.3.	Вывести список из 10 процессов занимающих дольше всего процессор. Результат записывать в файл.

[CmdletBinding()]
Param
(
    
    [string]$path = "E:\Epam. Training\",

    [string]$name_of_file = "Processes",

    [string]$expansion = ".txt"

)

Get-Process | Sort-Object UserProcessorTime -Descending -ErrorAction SilentlyContinue | `
Select-Object Name, Id, UserProcessorTime -First 10 > $path$name_of_file$expansion 