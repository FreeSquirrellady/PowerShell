# 1. Просмотреть содержимое ветви реeстра HKCU 
Get-PSDrive
Get-ChildItem HKCU:\

# 2. Создать, переименовать, удалить каталог на локальном диске
[string]$path = "C:\"
[string]$name = "Folder_Samusenko"
[string]$new = "Rename"
Set-Location $path # Move to $path
New-Item -Name $name -ItemType Directory # Create a new directory
Start=Sleep -Seconds 2
Rename-Item -LiteralPath $path$name -NewName $path$new # Rename
Start-Sleep -Seconds 2 # Sleep
Remove-Item -LiteralPath $path$new # Delete 

# 3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
[string]$path = "C:\"
[string]$name = "M2T2_Samusenko"
if ((Test-Path $path$name) -eq "True") # Delete directory if it exists
{
    Remove-Item -Path $path$name -Recurse
}
New-Item -Path $path -Name $name -ItemType Directory # Create a new directory
foreach ($x in Get-PSDrive) # Delete disk if it exists
{
    if ($x.Name -eq $name)
    {
        Remove-PSDrive -Name $name -Force
    }
}
New-PSDrive -Root $path -Name $name -PSProvider FileSystem # Create a new disk
Get-PSDrive | Select-Object Name # Check

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

# 5. Просуммировать все числовые значения переменных текущего сеанса.
[CmdletBinding()]
Param 
(
    [int]$a = 1, 
    [int]$b = 2,
    [int]$c = 3,
    [string]$st = "ABC",
    [int]$temp = 0
)

foreach ($x in (Get-Variable | Select-Object Value))
{
    
    if ($x.Value -is [int])
    {
        Write-Host("Intermediate value: " + $x.Value) -ForegroundColor Yellow
        $temp += $x.Value
    }
}
Write-Host("Sum = $temp.") -ForegroundColor Green

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

# 7. Вывести список названий и занятую виртуальную память (в Mb) каждого процесса, разделённые знаком тире, при этом если процесс занимает более 100Mb – выводить информацию красным цветом, иначе зелёным.
$array = @(Get-Process| Select-Object VirtualMemorySize, Name)
foreach($x in $array){
    if (($x.VirtualMemorySize / 1000000) -gt 100.0 )
    {
        Write-Host("Process: " + $x.Name + " - " + ( $x.VirtualMemorySize / 1000000) + " MB") -ForegroundColor Red
    }
    else 
    {
        Write-Host("Process: " + $x.Name + " - " + ( $x.VirtualMemorySize / 1000000) + " MB") -ForegroundColor Green    
    }
    
}

# 8. Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp 
$array = @(Get-ChildItem "C:\Windows" -Recurse -Force -Exclude "*.tmp" -file -ErrorAction SilentlyContinue | Select-Object Length)
$total_length = 0
foreach ($x in $array)
{
     $total_length += ($x.Length/1000000)    
}

Write-Output("The total value is: " + $total_length + " MB")

# 9. Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft. 
[string]$path = "C:\"
[string]$name = "Remove_after_check"
if ((Test-Path $path$name) -eq "True")
{
    Remove-Item -Path $path$name -Recurse -Confirm
}
New-Item -Path $path -Name $name -ItemType Directory
Set-Location HKLM:\SOFTWARE\Microsoft
Get-ChildItem > $path$name"\Info.csv" 

# 10.Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
[string]$path = "C:\"
[string]$name = "Remove_after_check"
if ((Test-Path $path$name) -eq "True")
{
    Remove-Item -Path $path$name -Recurse -Confirm
}
New-Item -Path $path -Name $name -ItemType Directory
Get-History > $path$name"\History.xml"

# 11.Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
[string]$path = "C:\Remove_after_check\History.xml"
Get-Content -Path $path | Select-Object PsPath, Length, PsProvider, ReadCount, PsChildName

# 12.Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
[string]$path = "C:\"
[string]$name = "M2T2_Samusenko"
if ((Test-Path $path$name) -eq "True") # Delete directory if it exists
{
    Remove-Item -Path $path$name -Recurse
}
New-Item -Path $path -Name $name -ItemType Directory 
foreach ($x in Get-PSDrive) # Delete disk if it exist
{
    if ($x.Name -eq $name)
    {
        Remove-PSDrive -Name $name -Force
    }
}
New-PSDrive -Root $path -Name $name -PSProvider FileSystem 

Remove-Item -Path $path$name -Recurse # Delete directory
Remove-PSDrive -Name $name -Force # Delete disk