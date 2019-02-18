#1.  Создайте сценарии *.ps1 дл я задач из labwork 2, проверьте их работоспостобность.
#1.1 Сохранить в текстовый файл на диске список запущенных(!) служб. Просмотреть содержимое диска. Вывести содержимое файла в консоль PS.
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
New-PSDrive -Name $name_of_disk -Root $root -PSProvider FileSystem # Create a disk
Set-Location $name_of_disk":\" # Move to the disk 
if ((Test-Path $root$name_of_directory"\") -eq "True") # Remove a directory if it exist
{
   Remove-Item -Path $name_of_disk":\"$name_of_directory"\" -Force -Recurse -Confirm 
}
New-Item -Path $name_of_disk":\" -Name $name_of_directory -ItemType Directory # Create a directory
Get-Service | Where-Object {$_.Status -eq 'Running'} > $name_of_disk":\"$name_of_directory"\"$name_of_file # Write data about services in te file
Get-ChildItem -Path $name_of_disk":\" # get content of disk
Get-Content $name_of_disk":\"$name_of_directory"\"$name_of_file # get data from file and write in console 

