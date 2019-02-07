#20. Напишите функцию для предыдущего задания. Запустите её на выполнение.

function sum
{
    $n = Read-Host "Input n: "
    $temp = 0
    for($i = 1; $i -le $n; $i++)
    {
        $temp += $i * 3
        Write-Output("Step: $temp")
    }
    Write-Output("Final sum = $temp")
}

sum