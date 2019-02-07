#19. Подсчитать значение выражения S= . N – изменяемый параметр. Каждый шаг выводить в виде строки. (Пример: На шаге 2 сумма S равна 9)
$n = Read-Host "Input n: "
$temp = 0
for($i = 1; $i -le $n; $i++)
{
    $temp += $i * 3
    Write-Output("Step: $temp")
}
Write-Output("Final sum = $temp")