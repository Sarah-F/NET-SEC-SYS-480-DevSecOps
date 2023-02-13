param (
    [Parameter(Mandatory=$true)]$shallBeCloned,
    [Parameter(Mandatory=$true)]$baseVM,
    [Parameter(Mandatory=$true)]$newVMName
)

function cloner($shallBeCloned, $baseVM, $newVMName){
  try{
    $vm = Get-VM -Name $shallBeCloned
    $snapshot = Get-Snapshot -VM $vm -Name $baseVM
    $vmhost = Get-VMHost -Name "192.168.7.31"
    $ds = Get-DataStore -Name "datastore1-super21"
    $linkedClone = "{0}.linked" -f $vm.name
    $linkedVM = New-VM -LinkedClone -Name $linkedClone -VM $vm -ReferenceSnapshot $snapshot -VMHost $vmhost -Datastore $ds
    $newvm = New-VM -Name "$newVMName.base" -VM $linkedVM -VMHost $vmhost -Datastore $ds
    $newvm | New-Snapshot -Name "Base"
   # $linkedvm | Remove-VM
  }
}
