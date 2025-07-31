$NamePC=$args[0];
Get-CimInstance -ClassName Win32_ComputerSystem -comp $NamePC | fl Manufacturer,Model;
sleep 2;
echo "CPU";
Get-CimInstance -ClassName Win32_Processor -comp $NamePC | fl;
sleep 2;
echo "RAM";
Get-CimInstance -ClassName Win32_PhysicalMemory -comp $NamePC | fl DeviceLocator,BankLabel,Manufacturer,PartNumber,Speed,FormFactor,@{label="Capacity (GB)"; Expression={$_.Capacity / 1gb}};
sleep 2;
echo "HDD";
Get-CimInstance -ClassName Win32_DiskDrive -comp $NamePC | fl MediaType,Model,@{label="Size";Expression={$_.Size / 1gb}};
sleep 2;
echo "Видеокарта";
Get-CimInstance -ClassName Win32_VideoController -comp $NamePC | fl Name,VideoProcessor,Status
sleep 2;
echo "Монитор"; 
gwmi -comp $NamePC WmiMonitorID -Namespace root\wmi | ForEach-Object {($_.UserFriendlyName -ne 0 | foreach {[char]$_}) -join "";};

