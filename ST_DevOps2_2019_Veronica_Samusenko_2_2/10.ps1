# 10.Сохранить в XML -файле историческую информацию о командах выполнявшихся в текущем сеансе работы PS.
[string]$path = "C:\"
[string]$name = "Remove_after_check"
if ((Test-Path $path$name) -eq "True")
{
    Remove-Item -Path $path$name -Recurse -Confirm
}
New-Item -Path $path -Name $name -ItemType Directory
Get-History > $path$name"\History.xml"