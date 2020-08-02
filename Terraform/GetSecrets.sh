#!/bin/bash
RESOURCEGROUP=$1
LOCATION=$2
ENV=$3
AppInsightsName=$ENV'-sap-appinsights'
SBNamespaceName=${ENV}"-sap-svcb"
EHNamespaceName=${ENV}"-sap-evth"
CosmosDBAccountName=${ENV}"-sap-cosdb-sql"
redisCache=($ENV'-sap-redis')
EvtHubStr=($ENV'sapbloblease')
FunStr=($ENV'sapfunctionstorage')
TableStr=($ENV'sapstorage')
DataLakeStr=($ENV'sapdatalake')
RedisKey=$(az redis list-keys -g $RESOURCEGROUP -n $redisCache --query primaryKey)
echo $RedisKey
redisConn=${RedisKey//\"/}
echo $redisConn
if [ ! -f ./config/$ENV'-secrets.yaml' ]; then
echo -e "Generating a $ENV-secrets.yaml file"
cat > ./config/$ENV'-secrets.yaml' <<EOL
apiVersion: v1
kind: Secret
metadata:
  namespace: sapphire-$ENV
  name: environment-settings
type: Opaque
stringData:
    config.yaml: |-
    APPINSIGHTS_INSTRUMENTATIONKEY: $(az resource show -g $RESOURCEGROUP -n $AppInsightsName --resource-type "Microsoft.Insights/components" --query properties.InstrumentationKey)
    EventHubManageConnectionString: $(az eventhubs namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $EHNamespaceName --name RootManageSharedAccessKey --query primaryConnectionString)
    EventHubWriteConnectionString: $(az eventhubs namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $EHNamespaceName --name SendPolicy --query primaryConnectionString)
    EventHubStorageConnectionString: $(az storage account show-connection-string -g $RESOURCEGROUP -n $EvtHubStr  --key primary --query connectionString)
    EventHubDuplexConnectionString: $(az eventhubs namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $EHNamespaceName --name DuplexPolicy --query primaryConnectionString)
    EventHubReadConnectionString: $(az eventhubs namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $EHNamespaceName --name ListenAccessKey --query primaryConnectionString)
    CosmosDbConfigDbKey: $(az cosmosdb list-connection-strings --name $CosmosDBAccountName --resource-group $RESOURCEGROUP --query connectionStrings[0].connectionString)
    CosmosDbName: "sapphire"
    CosmosDbEndPoint: "https://$CosmosDBAccountName.documents.azure.com:443/"
    ServiceBusManageConnectionString: $(az servicebus namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $SBNamespaceName --name RootManageSharedAccessKey --query primaryConnectionString)
    ServiceBusReadConnectionString: $(az servicebus namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $SBNamespaceName --name ListenAccessKey --query primaryConnectionString)
    ServiceBusWriteConnectionString: $(az servicebus namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $SBNamespaceName --name SendPolicy --query primaryConnectionString)
    ServiceBusDuplexConnectionString: $(az servicebus namespace authorization-rule keys list -g $RESOURCEGROUP --namespace-name $SBNamespaceName --name DuplexPolicy --query primaryConnectionString)
    TableStorageConnectionString: $(az storage account show-connection-string -g $RESOURCEGROUP -n $TableStr --key primary --query connectionString)
    DataLakeConnectionString: $(az storage account show-connection-string -g $RESOURCEGROUP -n $DataLakeStr --key primary --query connectionString)
    RedisCacheConnectionString: "${ENV}-sap-redis.redis.cache.windows.net:6380,password=$redisConn,ssl=True,abortConnect=False"
    ReconciliationApiUrl: "http://reconciliationapi.sapphire-$ENV.svc.cluster.local:9010"
    NotificationApiUrl: "http://notificationapi.sapphire-$ENV.svc.cluster.local:9010"
    SalesTransactionApiUrl: "http://salestransactionapi.sapphire-$ENV.svc.cluster.local:9010/"
    SiteConfigurationApiUrl: "http://siteconfigurationapi.sapphire-$ENV.svc.cluster.local:9010/"
    SiteDeliveriesApiUrl: "http://sitedeliveriesapi.sapphire-$ENV.svc.cluster.local:9010/"
    TankLevelWebApiConfigUrl: "http://tanklevelsapi.sapphire-$ENV.svc.cluster.local:9010/"
    WetStockReconcillationApiUrl: "http://reconciliationapi.sapphire-$ENV.svc.cluster.local:9010/"
    AzureWebJobsStorage: $(az storage account show-connection-string -g $RESOURCEGROUP -n $FunStr  --key primary --query connectionString)
EOL
fi