#9. Выводить сообщение при каждом запуске приложения MS Word.

Register-WmiEvent -Query "Select * From __instancecreationevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='WINWORD.EXE'" `
-sourceIdentifier "MS WORD UP" -Action { Write-Host "Microsoft Word has been started." } 
# The event will start, when MS WORD will start.  
Register-WmiEvent -Query "Select * From __instancedeletionevent within 5 where targetinstance isa 'Win32_Process' and targetinstance.name='WINWORD.EXE'" `
-sourceIdentifier "MS WORD DOWN" -Action { Write-Host "Microsoft Word has been closed." }
# The event will end, when MS WORD will close.  