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

#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)

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
        
        $temp += $x.Value
    }
}

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

# 1.3.1. Организовать запуск скрипта каждые 10 минут

[CmdletBinding()]
Param
(
    [string]$name = "List of processes",

    [string]$time_of_repeat = "00:10:00",

    [string]$path = "C:\Users\Veronika\Documents\ST_DevOps2_2019_Veronica_Samusenko\ST_DevOps2_2019_Veronica_Samusenko_2_3\1.3.ps1"

)
[string]$start_time = " $($(Get-Date).Hour):$($($(Get-Date).Minute) + 1):$($(Get-Date).Second)" # start script after 1 minute
$t = New-JobTrigger -RepetitionInterval $time_of_repeat -RepetitionDuration ([timespan]::MaxValue) -At $start_time -Once # Interval
$o = New-ScheduledJobOption -RunElevated # Running with privilege
Register-ScheduledJob -Name $name -FilePath $path -Trigger $t -ScheduledJobOption $o  # Running a script on a schedule 

#1.4. Подсчитать размер занимаемый файлами в папке (например C:\windows) 
#     за исключением файлов с заданным расширением(напрмер .tmp)

[CmdletBinding()]
Param 
(
    [parameter (Mandatory = $true, HelpMessage = "Enter the directory in which the search will be performed: ")]
    [string]$directory_for_search, #"C:\Windows\"

    [parameter (Mandatory = $true, HelpMessage = "Enter the exclude, which won't be counted: (tmp e.g.)")]
    [string]$for_exclude, # Расширение

    [int]$total_length = 0
)

$array = @(Get-ChildItem -Path $directory_for_search -Recurse -Exclude "*.$for_exclude" -file -ErrorAction SilentlyContinue | Select-Object Length)
foreach ($x in $array)
{
    $total_length += ($x.Length/1000000)    # length in bytes
}
Write-Output("The total value is: " + $total_length + " MB") 

#1.5    Создать один скрипт, объединив 3 задачи:
#1.5.1.	Сохранить в CSV-файле информацию обо всех обновлениях безопасности ОС.

[CmdletBinding()]
Param
(
    [string]$path = "C:\",

    [parameter (Mandatory = $true, HelpMessage = "Enter name of directory: ")]
    [string]$name_of_directory,

    [string]$name_of_file_csv = "/Updates.csv",

    [string]$name_of_file_xml = "/Notes.xml"

)

if ((Test-Path $path$name_of_directory) -eq "True") # Remove the directory if it exists
{
    Remove-Item -Path $path$name_of_directory -Recurse -Confirm
}
New-Item -Path $path -Name $name_of_directory -ItemType Directory # Create a directory
foreach ($x in Get-HotFix | Select-Object Description, HotFixID, InstalledBy, InstalledOn)
{
    if ($x.Description -eq "Security Update")
    {
        $x | Out-File -Append -FilePath  $path$name_of_directory$name_of_file_csv # Output HotFix with particular description
    }
} 

# 1.5.2. Сохранить в XML-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft.

Get-ChildItem -LiteralPath HKLM:\SOFTWARE\Microsoft > $path$name_of_directory$name_of_file_xml

#1.5.3.	Загрузить данные из полученного в п.1.5.1 или п.1.5.2 файла 
#       и вывести в виде списка  разным разными цветами

$data_about_OC = Get-Content -Path $path$name_of_directory$name_of_file_csv # Read data from file
$data_about_regedit = Get-Content -Path $path$name_of_directory$name_of_file_xml # The same

function out_put ($data, [System.ConsoleColor]$color) # function for output
{
    foreach ($x in $data)
    {
        Write-Host($x) -ForegroundColor $color
    }
}

out_put -data $data_about_OC -color "Green"
out_put -data $data_about_regedit -color "Red" 

#2.     Работа с профилем
#2.1.	Создать профиль

New-Item -ItemType File -Path $profile -Force 

#2.2.	В профиле изненить цвета в консоли PowerShell

(Get-Host).UI.RawUI.ForegroundColor = "Green"
(Get-Host).UI.RawUI.BackgroundColor = "Red"

#2.3.	Создать несколько собственных алиасов

Set-Alias Help Get-Help
Set-Alias print Write-Host

#2.4.	Создать несколько констант

Set-Variable PI -option Constant -Value 3.14 
Set-Variable g -Option Constant -Value 9.8

#2.5.	Изменить текущую папку

Set-Location E:\Epam. Training

#2.6.	Вывести приветсвие

Write-Host("Hello, Veronica!")

#2.7.	Проверить применение профиля

Help -Examples
print ("Check alias")
print ("This is my constant: $PI")
print ("g = $g") 

#3. Получить список всех доступных модулей.
Get-Module -listAvailable
