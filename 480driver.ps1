Import-Module '480-utils' -Force

#Call the banner function
480Banner

$conf = Get-480Config -config_path '/home/user3/Documents/GitHub/NET-SEC-SYS-480-DevSecOps/480.json'
480Connect -server $conf.vcenter_server

<#
# Select VM Function
Write-Host "Selecting your VM"
Select-VM -folder "BASEVM"
#>

<#
# Call the cloner
Write-Host "Clone a VM"
$shallBeCloned = Read-Host -Prompt "Enter the name of the vm you wish to clone"
$baseVM = Read-Host -Prompt "Enter the name of the base vm of the vm you wish to clone"
$newVMName = Read-Host -Prompt "Enter the name of your new vm"
Cloner -shallBeCloned $shallBeCloned -baseVM $baseVM -newVMName $newVMName
Get-VM
#>

<#
# Milestone6.1
# Create Virtual Machine and Port Group
Write-Host "Create a new virtual switch and port group"
$vSwitchName = Read-Host -Prompt "Enter the name of the virtual switch you wish to create"
$portGroupName = Read-Host -Prompt "Enter the name of the port group you wish to create"
Create_vSwitch -vSwitchName $vSwitchName -portGroupName $portGroupName
Get-VirtualSwitch
# Create vSwitch == New-Network
# Ran, new switch and port BLUE1-LAN, 
#>

<#
# Get IP Info
$vmName = Read-Host -Prompt "Enter the name of the vm you wish to get the IP of"
Get-IP -vCenterServer $conf.vcenter_server -vmName $vmName
#>

<#
# Milestone 6.2 - Deliverable 2
# use set network function after cloner instead of doing it all at oncee
# Call the cloner

linkedCloner -shallBeCloned '480-fw-2.base'-baseVM 'Base' -newVMName 'fw-blue3'
Set-VMNetwork -vmName 'fw-blue3' -networkName '480-WAN-PortGroup' -esxi_host_name $conf.esxi_host_name -vcenter_server $conf.vcenter_server
Get-VM
#>

<#
# Milestone 6.2 - Deliverable 3
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

<#
# Milestone 6.2 - Deliverable 4
#Set network adapter
Get-VM
$vmName = Read-Host -Prompt "Enter the name of the virtual machine you would like to select"
#Get-VirtualNetwork
$networkName = Read-Host -Prompt "Enter the name of the network you would like to select"
Set-VMNetwork -vmName $vmName -networkName $networkName -esxi_host_name $conf.esxi_host_name -vcenter_server $conf.vcenter_server
#network name = BLUE1-LAN
#>

<#
# Milestone 7
for ($i=1; $i -le 3; $i++){
    New-linkedCloner -shallBeCloned "rocky-base" -newVMName "rocky-$i" 
    Set-VMNetwork -vmName "rocky-*" -networkName 'BLUE1-LAN' -esxi_host_name $conf.esxi_host_name -vcenter_server $conf.vcenter_server
    VMStart -vmToStart "rocky-*"
}
#>
<#
for ($i=1; $i -le 3; $i++){
    Get-IP -vCenterServer $conf.vcenter_server -vmName "rocky-$i" 
}
#>

# Milestone 7.4 
<#
for ($i=1; $i -le 2; $i++){
    New-linkedCloner -shallBeCloned "xubuntu-base" -newVMName "ubuntu-$i" 
    Set-VMNetwork -vmName "ubuntu-*" -networkName 'BLUE1-LAN' -esxi_host_name $conf.esxi_host_name -vcenter_server $conf.vcenter_server
    VMStart -vmToStart "ubuntu-*"
}
#>
<#
for ($i=1; $i -le 2; $i++){
    Get-IP -vCenterServer $conf.vcenter_server -vmName "ubuntu-$i" 
}
#>

# Milestone 8
<#
New-linkedCloner -shallBeCloned "xubuntu-base" -newVMName "wazuh" 
Set-VMNetwork -vmName "wazuh" -networkName 'BLUE1-LAN' -esxi_host_name $conf.esxi_host_name -vcenter_server $conf.vcenter_server
VMStart -vmToStart "wazuh"
Get-IP -vCenterServer $conf.vcenter_server -vmName "wazuh" 

$vmName = Read-Host "Enter the name of the VM you wish to upgrade"
$memAmt = Read-Host "Enter new memory amount"
$cpuAmt = Read-Host "Enter new CPU amount"
Edit-VM -vmName $vmName -memAmt $memAmt -cpuAmt $cpuAmt


Get-IP -vCenterServer $conf.vcenter_server -vmName "wazuh"
#>

# Milestone 9
#New-linkedCloner -shallBeCloned "server-core-2019-base" -newVMName "dc-blue2" -datastoreNum "datastore1-super21" 
#VMStart -vmToStart "dc-blue2"

# Run Get-NetIPConfiguration in powershell - 6
<#
$VMName = Read-Host -Prompt "Enter vm name"
$interfaceIndex = Read-Host -Prompt "Enter interface index"
$IPAddr = Read-Host -Prompt "Enter ip addresss"
$netmask = Read-Host -Prompt "Enter netmask"
$gateway = Read-Host -Prompt "Enter gateway"
$guestUser = Read-Host -Prompt "Enter usename"
SetIP -VMName $VMName -interfaceIndex $interfaceIndex -IPAddr $IPAddr -netmask $netmask -gateway $gateway -nameserver $IPAddr -guestUser $guestUser -guestPass $guestPass
#>
#SetIP -VMName "dc-blue1" -interfaceIndex "Ethernet0" -IPAddr "10.0.5.6" -netmask "255.255.255.0" -gateway "10.0.5.2" -nameserver "10.0.5.2" -guestUser "deployer" -guestPass $guestPass
Get-IP -vCenterServer $conf.vcenter_server -vmName "dc-blue2"
#>

New-NetIPAddress -InterfaceIndex 6 -IPAddress 10.0.5.7 -PrefixLength 24 -DefaultGateway 10.0.5.2
Set-DnsClientServerAddress -InterfaceIndex 6 -ServerAddresses 10.0.5.2
Get-NetIPConfiguration
<#
Demo commands for 9.1
ssh deployer@10.0.5.5
ipconfig /all

Demo commands for 9.2
ssh deployer@10.0.5.5
powershell
hostname
whoami
Get-ADGroupMember -Identity "Domain Admins"
Get-ADOrganizationalUnit -LDAPFilter '(name=*)' -SearchBase 'OU=BLUE1,DC=sarah,DC=LOCAL' | Format-Table Name
#>