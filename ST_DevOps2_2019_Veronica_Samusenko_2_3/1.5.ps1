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