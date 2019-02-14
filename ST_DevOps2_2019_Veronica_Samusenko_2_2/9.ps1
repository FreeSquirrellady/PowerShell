# 9. Сохранить в CSV-файле информацию о записях одной ветви реестра HKLM:\SOFTWARE\Microsoft. 
[string]$path = "C:\"
[string]$name = "Remove_after_check"
if ((Test-Path $path$name) -eq "True")
{
    Remove-Item -Path $path$name -Recurse -Confirm
}
New-Item -Path $path -Name $name -ItemType Directory
Set-Location HKLM:\SOFTWARE\Microsoft
Get-ChildItem > $path$name"\Info.csv" 