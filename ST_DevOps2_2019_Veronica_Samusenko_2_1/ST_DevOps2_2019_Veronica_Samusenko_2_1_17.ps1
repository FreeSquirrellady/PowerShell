#17 Выведите дату и время, когда был запущен процесс «explorer». Получите какой это день недели. 
$start = (Get-Process explorer).StartTime
$day = (Get-Date -Date 07.02.2019).DayOfWeek
Write-Output("Start of program: $start. It was a: $day.")