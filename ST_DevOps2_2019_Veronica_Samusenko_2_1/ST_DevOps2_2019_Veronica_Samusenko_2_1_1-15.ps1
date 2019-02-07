#1	Получите справку о командлете справки
Get-Help Get-Help

#2 Пункт 1, но детальную справку, затем только примеры
Get-Help Get-Help -Detailed
Get-Help Get-Help -Examples

#3 Получите справку о новых возможностях в PowerShell 4.0 (или выше)
Get-Help about_Windows_Powershell_5.0

#4 Получите все командлеты установки значений
Get-Command Set-* -CommandType Cmdlet

#5Получить список команд, работающих с файлами
Get-Command *File*

#6 Получить список команд рабты с объектами
Get-Command *Object*

#7 Получить список всех псевдонимов
Get-Alias

#8 Создать псевдоним для любого командлета
Set-Alias ghelp Get-Help

#9 Просмотреть список свойств и методов объекта типа процесс
Get-Process | Get-Member -MemberType Properties
Get-Process | Get-Member -MemberType Methods

#10 Просмотреть список свойств и методов объекта типа строка
[string]$string = "Hello world!"
$string | Get-Member

#11 Получить список запущенных процессов, данные об определённом процессе
Get-Process
Get-Process -Name System

#12 Получить список всех сервисов, данные об определенном сервисе
Get-Service
Get-Process -Name WSearch

#13 Получить список обновлений системы
Get-HotFix

#14 Узнайте, какой язык установлен для UI Windows
Get-WinSystemLocale

#15 Получите текущее время и дату
Get-Date