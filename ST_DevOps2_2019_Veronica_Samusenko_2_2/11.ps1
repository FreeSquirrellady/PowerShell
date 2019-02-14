# 11.Загрузить данные из полученного в п.10 xml-файла и вывести в виде списка информацию о каждой записи, в виде 5 любых (выбранных Вами) свойств.
[string]$path = "C:\Remove_after_check\History.xml"
Get-Content -Path $path | Select-Object PsPath, Length, PsProvider, ReadCount, PsChildName