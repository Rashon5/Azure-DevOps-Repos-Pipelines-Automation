#!/bin/bash

# Define the resource group containing the storage accounts
RESOURCE_GROUP="<your-resource-group>"

# Delete storage accounts
az storage account delete --name jwtst --resource-group $RESOURCE_GROUP --yes
az storage account delete --name jwqa --resource-group $RESOURCE_GROUP --yes
az storage account delete --name jwprd --resource-group $RESOURCE_GROUP --yes

echo "Storage accounts jwtst, jwqa, and jwprd have been deleted."
