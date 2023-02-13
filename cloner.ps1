function cloner($shallBeCloned, $baseVM, $newVMName){
  try{
    Write-Host $shallBeCloned
    Write-Host $baseVM
    Write-Host $newVMName
  
    $vm = Get-VM -Name $shallBeCloned
    $snapshot = Get-Snapshot -VM $vm -Name $baseVM
    $vmhost = Get-VMHost -Name "192.168.7.31"
    $ds = Get-DataStore -Name "datastore1-super21"
    $linkedClone = "{0}.linked" -f $vm.name
    $linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
    $newvm = New-VM -Name "$newVMName.base" -VM $linkedVM -VMHost $vmhost -Datastore $ds
    $newvm | New-Snapshot -Name "Base"
    $linkedvm | Remove-VM
  }
  catch {
    Write-Host "ERROR"
    exit
  }
}

# Run first cloner command with xubuntu, run second with vcenter 
#cloner -shallBeCloned "xubuntu-wan" -baseVm "Base-xubuntu" -newVMName "xubuntu-wan-2"
cloner -shallBeCloned "vcenter" -baseVm "Base-vcenter" -newVMName "vcenter-2"
