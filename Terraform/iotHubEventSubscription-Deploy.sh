#!/bin/bash
# iot HUB Event Grid Subscription Properties

RESOURCEGROUP=$1
ENV=$2
SUB=$3
iotHubName=$4
eventHubNameSpace=$5
#iotHubName=($ENV'-sap-ioth')
#eventHubNameSpace=($ENV'-sap-evth')

function createEventGridSubscription(){
    eventHubName=$1
    eventSubscriptionName=$2
    filterMessageType=$3

    subscriptionIdCheck="/subscriptions/$SUB/resourcegroups/$RESOURCEGROUP/providers/Microsoft.Devices/IotHubs/$iotHubName/providers/Microsoft.EventGrid/eventSubscriptions/$eventSubscriptionName"

    checkResult=$(az resource show \
                    --resource-group $RESOURCEGROUP \
                    --ids ${subscriptionIdCheck})

    if [ "$checkResult" = "" ]; then
        echo "Creating IOT Hub EventGrid Subscription $eventSubscriptionName"
        az deployment group create \
            --resource-group $RESOURCEGROUP \
            --template-file "./iotHubEventSubscription.json" \
            --parameters \
                resourceGrp="$RESOURCEGROUP" \
                subscriptd="$SUB" \
                iotHubName="$iotHubName" \
                eventHubNameSpace="$eventHubNameSpace" \
                eventHubName="$eventHubName" \
                eventSubscriptionName="$eventSubscriptionName" \
                filterMessageType="$filterMessageType"
    else
        echo " IOT Hub EventGrid Subscription $eventSubscriptionName already exists"
    fi
}
createEventGridSubscription 'tankinventories' 'tankinventories' 'atg-tank-inventory'
createEventGridSubscription 'salestransactions' 'salestransactions' 'fuel-sale-transaction'
createEventGridSubscription 'atgconfigs' 'atgconfigs' 'atg-tank-configuration'
createEventGridSubscription 'nozzleconfigs' 'nozzleconfigs' 'nozzle-configuration'

