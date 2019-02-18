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