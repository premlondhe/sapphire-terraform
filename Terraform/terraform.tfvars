azure_subscription_id = "1f91fd91-e09c-46fb-83c7-9ba7269f22a1"
azure_client_id = "be445792-ee6b-4869-a5bb-fc1e73bbe11f"
azure_tenant_id = "aba84a1b-63f3-46f3-80cf-5273d2c74cb6"
azure_client_secret = "_461m.-Hu8l8AFq-2c6n_lz6stknO9qd0_"

azenv="tf"

storageaccounts=["sapbloblease", "sapstorage", "sapfunctionstorage"]
storagetables=["atgalertscodedescription", "confirmeddeliverieslookup", "tankchartlevel"]
storagecontainers=["azure-confirmed-deliveries", "azure-sirdatafiles", "azure-sapphire-adapter", "azure-sapphire-adapter-unzipped", "detecteddeliveries", "azure-filedataimport"]

eventhubns = ["sap-evth", "sap-evth2"]	

sbqpartitionenable=["siteconfiganomalies", "dailydatarequests", "tankchartrequests"]
sbqpartitiondisable=["rolluptasks", "sirrequests", "sapphireadapterfilesqueue", "siteconfig-warehouse-requests", "inventorycontrolreportrequests", "regeneraterecrequest"]

sbtopics=["alerts", "tankinventories"]
sbtopicalertssubscription=["dailyalerts", "smartalerts", "datasubmissionalerts", "atgalerts", "continuousrecalerts"]
sbtopictankinventoriessubscription=["smartalerts", "smartwater"]

eventhubs=["atgconfigs", "detecteddeliveries", "nozzleconfigs", "reconciliations", "rollupevents", "latedata", "salestransactions", "tankinventories"]
eventhubs2=["real-time-rec-req", "buffered-real-time-rec-req", "realtime-stock-rec-snapshots", "interval-snapshots", "alerts", "notifications"]

redisacc=["sap-redis"]
workspacename="sap-databricks"
