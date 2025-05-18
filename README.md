//Created by Jacob Graham. 

Template 1.)CreateFreeLinVMInSameRegionAsSub.bicep

What it does: Creates an Ubuntu 22.04 VM in the free tier, in the same region your subscription is in without a public IP. 

Why I created this: Microsoft are sneaky bastards. When you create a VM using the free services it always adds a public IP by default which isn't free.  I also add good comments. 

To Run From Azure CLI:

az deployment group create \
  --resource-group myRg \
  --template-file CreateFreeLinVMInSameRegionAsSub.bicep \
  --parameters \
      adminUsername=YourUsername \
      adminPassword='YourPassword'

///////////////////////////////////////////////////////////////////////////

Template 2.) CreateFreeLinVMInSameRegionAsSubExtra.bicep

Does the same thing as the non extra one but adds commented-out switches for:

- Public IP creation
- Custom VM size
- Boot diagnostics
- Custom script/OS extensions


Each has clear comments on how to uncomment and configure. 

What it does: Creates an Ubuntu 22.04 VM in the free tier, in the same region your subscription is in without a public IP. 

Why I created this: Microsoft are sneaky bastards. When you create a VM using the free services it always adds a public IP by default which isn't free.  I also add good comments. 

To Run From Azure CLI:

az deployment group create \
  --resource-group myRg \
  --template-file CreateFreeLinVMInSameRegionAsSubExtra.bicep \
  --parameters \
      adminUsername=YourUsername \
      adminPassword='YourPassword'
