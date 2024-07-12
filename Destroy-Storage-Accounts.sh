#!/bin/bash

# Delete storage accounts
az storage account delete --name jwtst --resource-group azurebootcamp --yes
az storage account delete --name jwqa --resource-group azurebootcamp --yes
az storage account delete --name jwprd --resource-group azurebootcamp --yes

echo "Storage accounts jwtst, jwqa, and jwprd have been deleted."