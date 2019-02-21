# 1.	Вывести список событий-ошибок из системного лога, за последнюю неделю. 
# Результат представить в виде файла XML.
$a=(Get-EventLog -LogName System | select -first 1)
Get-EventLog -LogName System | Where-Object {$_.TimeGenerated -gt $a.TimeGenerated.AddDays(-7)} |  Export-Clixml "C:\temp\1.xml"


#2.	Вывести список файлов *.log хранящихся в папке C:\Windows. Вывод организовать в виде таблицы с обратной сортировкой по имени файла, 
#при этом выводить полное имя файла, размер файла, время создания. 
dir C:\Windows -Filter *.log | Sort Name -Descending | Select Name, Length, LastwriteTime

#3.	Создать файл-сценарий вывода всех чисел делящихся без остатка на 3, на интервале от А до В,
#где А и В — входные параметры, параметр А по умолчанию равен 0, параметр В обязателен для ввода.
  [Cmdletbinding()]
Param 
(  
    
   
    [int32]$A=0,
    [parameter(Mandatory = $true, HelpMessage="enter B")]
    [int]$B
)

for($A=0;$A -lt $B;$A++)
{
  if($A%3 -eq 0){Write-Output $A}
}

# 4. Проверить на удалённых компьютерах состояние одной службы (имя определить самостоятельно). 
#Перечень имен компьютеров должен браться из текстового файла. Вывод организовать следующим образом:
# Имя компьютера – статус (если служба запущена, то строка зелёная, иначе красная)





#5.Все файлы из прилагаемого архива перенести в одну папку, не содержащую подпапок. 
#Имя каждого файла изменить, добавив в его начало имя родительской папки и время переноса файла. 
#В конце выдать отчёт о количестве файлов и общем размере перенесённых файлов. 
New-Item -Path 'E:\4' -ItemType "directory"             #create new directory 
New-Item -Path 'E:\4\n' -ItemType "directory" 
New-Item -Path 'E:\4\file.txt' -ItemType "file"         #create new files
New-Item -Path 'E:\4\test.txt' -ItemType "file"
New-Item -Path 'E:\4\newfile.txt' -ItemType "file" 

Get-ChildItem E:\4* -Include *.txt |
Where-Object `
{ $_.LastAccessTime -gt ($(Get-Date).AddMonths(-1))} |
ForEach-Object { Move-Item $_.FullName E:\4\n}


Add-Type -AssemblyName "System.IO.Compression.FileSystem" 

# Каталог, который будем архивировать
$Source = 'E:\4'
# Путь, куда положить готовый архив
$ArchiveFileName = 'E:\archive.zip'
# Архивируем
[IO.Compression.ZipFile]::CreateFromDirectory($Source, $ArchiveFileName)

# Путь к архиву
$ArchiveFileName = 'E:\archive.zip'
# Путь, куда разархивировать
$ExtractPath = 'E:\unzip'
# Разархивируем
[IO.Compression.ZipFile]::ExtractToDirectory($ArchiveFileName, $ExtractPath)

