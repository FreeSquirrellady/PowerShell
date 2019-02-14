# 4. Сохранить в текстовый файл на созданном диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
[CmdletBinding()]
Param 
(
    
    [parameter(Mandatory = $true, HelpMessage = "Enter name of disk:")]
    [string]$name_of_disk,
    
    [string]$root = "C:\",
    
    [parameter(Mandatory = $true, HelpMessage = "Enter name of directory:")]
    [string]$name_of_directory,

    [string]$name_of_file = "Status.txt"
)
New-PSDrive -Name $name_of_disk -Root $root -PSProvider FileSystem
Set-Location $name_of_disk":\"
if ((Test-Path $root$name_of_directory"\") -eq "True") # Remove a directory if it exist
{
   Remove-Item -Path $name_of_disk":\"$name_of_directory"\" -Force -Recurse
}
New-Item -Path $name_of_disk":\" -Name $name_of_directory -ItemType Directory
Get-Service | Where-Object {$_.Status -eq 'Running'} > $name_of_disk":\"$name_of_directory"\"$name_of_file
Get-ChildItem -Path $name_of_disk":\" 
Get-Content $name_of_disk":\"$name_of_directory"\"$name_of_file