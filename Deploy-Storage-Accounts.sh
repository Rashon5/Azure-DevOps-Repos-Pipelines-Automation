#!/bin/bash

az storage account create \
    --name jwtst \
    --resource-group azurebootcamp \
    --location eastus \
    --sku Standard_LRS \
    --kind StorageV2

az storage account create \
    --name jwqa \
    --resource-group azurebootcamp \
    --location eastus \
    --sku Standard_LRS \
    --kind StorageV2

az storage account create \
    --name jwprd \
    --resource-group azurebootcamp \
    --location eastus \
    --sku Standard_LRS \
    --kind StorageV2
