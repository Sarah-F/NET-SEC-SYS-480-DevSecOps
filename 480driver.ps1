Import-Module '480-utils' -Force
#Call the banner function
480Banner
$conf = Get-480Config -config_path = "/home/user3/Documents/GitHub/NET-SEC-SYS-490-DevSecOps"
480Connect -server $conf.vcenter_server
Write-Host "Selecting your VM"
Select-VM -folder "BASEVM"