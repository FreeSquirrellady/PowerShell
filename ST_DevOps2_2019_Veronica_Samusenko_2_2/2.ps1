# 2. Создать, переименовать, удалить каталог на локальном диске
[string]$path = "C:\"
[string]$name = "Folder_Samusenko"
[string]$new = "Rename"
Set-Location $path # Move to $path
New-Item -Name $name -ItemType Directory # Create a new directory
Start=Sleep -Seconds 2
Rename-Item -LiteralPath $path$name -NewName $path$new # Rename
Start-Sleep -Seconds 2 # Sleep
Remove-Item -LiteralPath $path$new # Delete 