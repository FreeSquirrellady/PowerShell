#2.7. Удалить созданную виртуальную машину
#Удаляем Виртуальный диск
Remove-VMHardDiskDrive -VMName NewVM -ControllerType IDE -ControllerNumber 1 -ControllerLocation 0
#Удаляем ВМ 
Remove-VM -Name "NewVM" -Force