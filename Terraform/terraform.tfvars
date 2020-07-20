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

#Azure DataWarehouse Firewall Rules
start_ipadd_list=["0.0.0.0","85.115.52.0","217.37.201.145","81.137.30.129","81.150.209.81","81.150.205.97","81.128.183.164","213.120.94.100"]
end_ipaddr_list=["0.0.0.0","85.115.52.255","217.37.201.145","81.137.30.129","81.150.209.81","81.150.205.97","81.128.183.164","213.120.94.100"]
firewall_rule_name=["AllowAllWindowsAzureIps","Fairbanks Analysts","FB ADSL 1","FB ADSL 2","FB ADSL 3","FB ADSL 4","FB LPool BT NET","FB SKem BT NET"]

#Azure Datafactory VSTS Configuration 
account_name="TestAccount"		
branch_name="master"		
project_name="Sapphire"		
repository_name="DataWarehouse"	
root_folder="DataFactory"		

#Sir ML Server
nsg-port-list=["ssh","http","https","ml_server_port"]
nsg-priority-list=["1010","1020","1030","1040"]
nsg-description-list=["Allow SSH connection","Allow Http connection","Allow https connection","Allow ml server port"]
nsg-destination-port-range-list=["22","80","443","12800"]
admin_username="wyane"
