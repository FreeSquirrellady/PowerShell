#1.4. Подсчитать размер занимаемый файлами в папке (например C:\windows) 
#     за исключением файлов с заданным расширением(напрмер .tmp)

[CmdletBinding()]
Param 
(
    [parameter (Mandatory = $true, HelpMessage = "Enter the directory in which the search will be performed: ")]
    [string]$directory_for_search, #"C:\Windows\"

    [parameter (Mandatory = $true, HelpMessage = "Enter the exclude, which won't be counted: (tmp e.g.)")]
    [string]$for_exclude, # Расширение

    [int]$total_length = 0
)

$array = @(Get-ChildItem -Path $directory_for_search -Recurse -Exclude "*.$for_exclude" -file -ErrorAction SilentlyContinue | Select-Object Length)
foreach ($x in $array)
{
    $total_length += ($x.Length/1000000)    # length in bytes
}
Write-Output("The total value is: " + $total_length + " MB")