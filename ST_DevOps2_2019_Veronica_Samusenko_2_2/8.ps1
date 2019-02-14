# 8. Подсчитать размер занимаемый файлами в папке C:\windows (и во всех подпапках) за исключением файлов *.tmp 
$array = @(Get-ChildItem "C:\Windows" -Recurse -Force -Exclude "*.tmp" -file -ErrorAction SilentlyContinue | Select-Object Length)
$total_length = 0
foreach ($x in $array)
{
     $total_length += ($x.Length/1000000)    
}

Write-Output("The total value is: " + $total_length + " MB")