# for awx

function cloner($shallBeCloned, $baseVM, $linkedCloneName, $newVMName){
  try{
    Write-Host $shallBeCloned
    Write-Host $baseVM
    Write-Host $linkedCloneName
    Write-Host $newVMName
  
    $vm = Get-VM -Name $shallBeCloned
    $snapshot = Get-Snapshot -VM $vm -Name $baseVM
    $vmhost = Get-VMHost -Name "192.168.7.31"
    $ds = Get-DataStore -Name "datastore1-super21"
    $linkedClone = $linkedCloneName
    $linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
    $linkedVM | Get-NetworkAdapter | Set-NetworkAdapter -NetworkName 480-WAN-PortGroup
    #$linkedvm | Remove-VM
  }
  catch {
    Write-Host "ERROR"
    exit
  }
}
 
cloner -shallBeCloned "xubuntu-base" -baseVm "Base-xubuntu-base" -linkedCloneName "awx" -newVMName "xubuntu-base-2"
