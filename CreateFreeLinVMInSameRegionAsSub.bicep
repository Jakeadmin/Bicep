//Created By Jacob Graham, Note:These are only free for 750 hours. 
@description('Name of your new VM goes here')
param vmName string = 'freeVM'

@description('Admin username for the Linux VM, must be lowercase for Linux')
param adminUsername string = 'azureuser'

@secure()
@description('Admin password for the VM (Windows) or SSH key (Linux)')
param adminPassword string

// Use the same region as the resource group, this will also make the RG you set in the command you run your region of choice
var location = resourceGroup().location

// Virtual network for the VM, if you have custom address sprace or subnet, you can add them here.
resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: '${vmName}-vnet'
  location: location
  properties: {
    addressSpace: { addressPrefixes: [ '10.0.0.0/16' ] }
    subnets: [
      {
        name: 'default'
        properties: { addressPrefix: '10.0.0.0/24' }
      }
    ]
  }
}

// Creates the NIC without a public IP, this ensures its actually free. Free resources in Azure come with Public IPs by default and they charge for thus, this removes that. 
resource nic 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: { id: vnet.properties.subnets[0].id }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

// Free-tier Linux VM (Standard_B1ls) is 100% free for 750 hours
resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: { vmSize: 'Standard_B1s' }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: { storageAccountType: 'Standard_LRS' }
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: { networkInterfaces: [{ id: nic.id }] }
  }
}

output vmResourceId string = vm.id
