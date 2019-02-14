# 3. Создать папку C:\M2T2_ФАМИЛИЯ. Создать диск ассоциированный с папкой C:\M2T2_ФАМИЛИЯ.
[string]$path = "C:\"
[string]$name = "M2T2_Samusenko"
if ((Test-Path $path$name) -eq "True") # Delete directory if it exists
{
    Remove-Item -Path $path$name -Recurse
}
New-Item -Path $path -Name $name -ItemType Directory # Create a new directory
foreach ($x in Get-PSDrive) # Delete disk if it exists
{
    if ($x.Name -eq $name)
    {
        Remove-PSDrive -Name $name -Force
    }
}
New-PSDrive -Root $path -Name $name -PSProvider FileSystem # Create a new disk
Get-PSDrive | Select-Object Name # Check