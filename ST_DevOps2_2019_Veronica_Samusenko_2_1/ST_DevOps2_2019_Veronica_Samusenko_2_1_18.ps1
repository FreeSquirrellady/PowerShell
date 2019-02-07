#18 Откройте любой документ в MS Word (не важно как) и закройте его с помощью PowerShell
$path = "C:\Topic_1_M_2.txt"
notepad.exe $path # I don't have MS Word
Start-Sleep(2) # Delay 2 sec.
Stop-Process -Name notepad