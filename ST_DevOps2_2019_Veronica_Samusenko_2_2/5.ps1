# 5. Просуммировать все числовые значения переменных текущего сеанса.
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
        Write-Host("Intermediate value: " + $x.Value) -ForegroundColor Yellow
        $temp += $x.Value
    }
}
Write-Host("Sum = $temp.") -ForegroundColor Green