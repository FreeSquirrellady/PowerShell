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