#!/bin/bash
RESOURCEGROUP=$1
CosmosDBAccount=$2
CosmosDatabaseList=('Sapphire' 'SiteExporter')
Throughput=2000

function createDatabase
{
arr=("$@")
   for i in "${arr[@]}"; 
      do
         echo "Creating cosmos database ${i}"
         RESULT=$(az cosmosdb database show -d $i -g $RESOURCEGROUP -n $CosmosDBAccount)
         if [ "$RESULT" == "" ]
         then
            az cosmosdb database create -d $i -n $CosmosDBAccount -g $RESOURCEGROUP --throughput $Throughput
         else
            echo "   Cosmos DB database $i already exists in $CosmosDBAccount account"
         fi
   done
}
createDatabase "${CosmosDatabaseList[@]}"

declare -A CollectionNames
CollectionNames+=(["alerts"]="/siteId" ["config"]="/id" ["confirmed-deliveries"]="/siteId" ["data-submission"]="/siteId" \
["delivery-intervals"]="/siteId" ["detected-deliveries"]="/siteId" ["hourly-recs"]="/siteId" ["metercalibration"]="/siteId" \
["notifications"]="/id" ["real-time-stock-recs"]="/siteId" ["reports"]="/siteId" ["reconciled-deliveries"]="/siteId" \
["real-time-sales-recs"]="/siteId" ["sales-transactions"]="/siteId" ["settings"]="/name" \
["sir"]="/siteId" ["siteconfig"]="/siteId" ["tank-activity-intervals"]="/siteId" ["tank-inventories"]="/siteId" \
["filetypes"]="/id" ["daily-reconciliation-source"]="/siteId")

declare -A Index
Index+=(["alerts"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["config"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["confirmed-deliveries"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["data-submission"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["delivery-intervals"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]},{"path":"\/siteId\/?","indexes":[{"kind":"Range","dataType":"String","precision":-1},{"kind":"Range","dataType":"Number","precision":-1}]},{"path":"\/StartTimeUtc\/?","indexes":[{"kind":"Range","dataType":"String","precision":-1},{"kind":"Range","dataType":"Number","precision":-1}]},{"path":"\/EndTimeUtc\/?","indexes":[{"kind":"Range","dataType":"String","precision":-1},{"kind":"Range","dataType":"Number","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["detected-deliveries"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["hourly-recs"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["metercalibration"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]},{"path":"\/nozzleId\/?","indexes":[{"kind":"Range","dataType":"String","precision":-1},{"kind":"Range","dataType":"Number","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["notifications"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["real-time-sales-recs"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["real-time-stock-recs"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["reconciled-deliveries"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["reports"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["sales-transactions"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["settings"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["sir"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["siteconfig"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]},{"path":"\/siteId\/?","indexes":[{"kind":"Range","dataType":"String","precision":-1},{"kind":"Range","dataType":"Number","precision":-1}]},{"path":"\/startDate\/?","indexes":[{"kind":"Range","dataType":"String","precision":-1},{"kind":"Range","dataType":"Number","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["tank-activity-intervals"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["tank-inventories"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*","indexes":[{"kind":"Range","dataType":"Number","precision":-1},{"kind":"Range","dataType":"String","precision":-1}]}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["filetypes"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["daily-reconciliation-source"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}')

 declare -A SiteExporterCollectionNames
SiteExporterCollectionNames+=(["ExportTriggerMessage"]="/id" ["OrganizationMapping"]="/id" ["SiteData"]="/id")

declare -A SiteExporterCollectionsIndex
SiteExporterCollectionsIndex+=(["ExportTriggerMessage"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["OrganizationMapping"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}' \
 ["SiteData"]='{"indexingMode":"consistent","automatic":true,"includedPaths":[{"path":"\/*"}],"excludedPaths":[{"path":"\/\"_etag\"\/?"}]}')

function createCollections
{
   var=$(declare -p "$1")
   eval "declare -A arr="${var#*=}
   database="$2"
   collectionIndex="$3"
   for i in "${!arr[@]}"; 
      do
         echo "Creating cosmos db collection  $i"
		   RESULT=$(az cosmosdb collection show -c $i -d $database -g $RESOURCEGROUP -n $CosmosDBAccount)
		   if [ "$RESULT" == "" ]
		      then
			  az cosmosdb collection create -c $i -d $database -g $RESOURCEGROUP -n $CosmosDBAccount --partition-key-path ${arr[${i}]} --indexing-policy ${collectionIndex[${i}]}
		   else
    	       echo "Cosmosdb collection $i already exists"
         fi
   done
 }
createCollections "CollectionNames" "Sapphire" "${Index[@]}"
createCollections "SiteExporterCollectionNames" "SiteExporter" "${SiteExporterCollectionsIndex[@]}"
