Import-Module '480-utils' -Force
#Call the banner function
480Banner

$conf = Get-480Config -config_path '/home/user3/Documents/GitHub/NET-SEC-SYS-480-DevSecOps/480.json'
480Connect -server $conf.vcenter_server

Write-Host "Selecting your VM"
Select-VM -folder "BASEVM"


#Call the cloner
Write-Host "Clone a VM"
$shallBeCloned = Read-Host -Prompt "Enter the name of the vm you wish to clone"
$baseVM = Read-Host -Prompt "Enter the name of the base vm of the vm you wish to clone"
$newVMName = Read-Host -Prompt "Enter the name of your new vm"
Cloner -shallBeCloned $shallBeCloned -baseVM $baseVM -newVMName $newVMName
Get-VM