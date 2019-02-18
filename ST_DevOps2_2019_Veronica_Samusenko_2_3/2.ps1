#2.     Работа с профилем
#2.1.	Создать профиль

New-Item -ItemType File -Path $profile -Force 

#2.2.	В профиле изненить цвета в консоли PowerShell

(Get-Host).UI.RawUI.ForegroundColor = "Green"
(Get-Host).UI.RawUI.BackgroundColor = "Red"

#2.3.	Создать несколько собственных алиасов

Set-Alias Help Get-Help
Set-Alias print Write-Host

#2.4.	Создать несколько констант

Set-Variable PI -option Constant -Value 3.14 
Set-Variable g -Option Constant -Value 9.8

#2.5.	Изменить текущую папку

Set-Location E:\Epam. Training

#2.6.	Вывести приветсвие

Write-Host("Hello, Veronica!")

#2.7.	Проверить применение профиля

Help -Examples
print ("Check alias")
print ("This is my constant: $PI")
print ("g = $g")