#!/bin/bash
# SQL database create properties

RESOURCEGROUP=$1
server=$2
dbName=$3


#Create a standard Azure SQL instance
RESULT=$(az sql db show \
    --resource-group $RESOURCEGROUP \
    --name $dbName \
    --server $server)

if [ "$RESULT" = "" ]; then
    echo "Creating SQL database $server\\$dbName"
    az sql db create \
        --resource-group $RESOURCEGROUP \
        --name $dbName \
        --server $server \
        --capacity 2 \
        --compute-model Serverless \
        --edition GeneralPurpose \
        --family Gen5 \
        --license LicenseIncluded \
        --auto-pause-delay -1
else
    echo "  Azure SQL database $server\\$dbName already exists"
fi

