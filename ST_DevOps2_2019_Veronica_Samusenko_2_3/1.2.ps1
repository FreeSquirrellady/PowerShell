#1.2.	Просуммировать все числовые значения переменных среды Windows. (Параметры не нужны)

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
        
        $temp += $x.Value
    }
}
