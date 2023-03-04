Import-Module '480-utils' -Force

#Call the banner function
480Banner

$conf = Get-480Config -config_path '/home/user3/Documents/GitHub/NET-SEC-SYS-480-DevSecOps/480.json'
480Connect -server $conf.vcenter_server








<#
# Select VM Function
Write-Host "Selecting your VM"
Select-VM -folder "BASEVM"


# Call the cloner
Write-Host "Clone a VM"
$shallBeCloned = Read-Host -Prompt "Enter the name of the vm you wish to clone"
$baseVM = Read-Host -Prompt "Enter the name of the base vm of the vm you wish to clone"
$newVMName = Read-Host -Prompt "Enter the name of your new vm"
Cloner -shallBeCloned $shallBeCloned -baseVM $baseVM -newVMName $newVMName
Get-VM
#>

<#
#Milestone6.1
# Create Virtual Machine and Port Group
Write-Host "Create a new virtual switch and port group"
$vSwitchName = Read-Host -Prompt "Enter the name of the virtual switch you wish to create"
$portGroupName = Read-Host -Prompt "Enter the name of the port group you wish to create"
Create_vSwitch -vSwitchName $vSwitchName -portGroupName $portGroupName
Get-VirtualSwitch

$vmName = Read-Host -Prompt "Enter the name of the virtual machine you would like the IP of"
Get-IP -vmName $vmName -vcenter_server 'vcenter.sarah.local'


#Milestone6.2
# Create Start and Stop Function
$vmToCheck = Read-Host -Prompt "Enter the name of the virtual machine you would like to ccheck the status of"
VMStatus -vmToCheck $vmToCheck

$vmToStart = Read-Host -Prompt "Enter the name of the virtual machine you would like to start"
VMStart -vmToStart $vmToStart
Get-VM

$vmToStop = Read-Host -Prompt "Enter the name of the virtual machine you would like to stop"
VMStop -vmToStop $vmToStop
Get-VM
#>

#Set network adapter
Get-VM
$vmName = Read-Host -Prompt "Enter the name of the virtual machine you would like to select"
Get-VirtualNetwork
$networkName = Read-Host -Prompt "Enter the name of the network you would like to select"
Set-VMNetwork -vmName $vmName, -networkName $networkName, -esxi_host_name $conf.esxi_host_name, -vcenter_server $conf.vcenter_server


