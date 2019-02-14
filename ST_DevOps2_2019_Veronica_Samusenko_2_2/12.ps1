# 12.Удалить созданный диск и папку С:\M2T2_ФАМИЛИЯ
[string]$path = "C:\"
[string]$name = "M2T2_Samusenko"
if ((Test-Path $path$name) -eq "True") # Delete directory if it exists
{
    Remove-Item -Path $path$name -Recurse
}
New-Item -Path $path -Name $name -ItemType Directory 
foreach ($x in Get-PSDrive) # Delete disk if it exist
{
    if ($x.Name -eq $name)
    {
        Remove-PSDrive -Name $name -Force
    }
}
New-PSDrive -Root $path -Name $name -PSProvider FileSystem 

Remove-Item -Path $path$name -Recurse # Delete directory
Remove-PSDrive -Name $name -Force # Delete disk