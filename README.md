//Created by Jacob Graham. 

1.)CreateFreeLinVMInSameRegionAsSub.bicep

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
