azure_subscription_id = ""
azure_client_id = ""
azure_tenant_id = ""
azure_client_secret = ""

azenv="pvn"

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


#Kubernetes AKS
agents_size="Standard_B2s"
agents_count="1"
aks_admin_username="aksuser"
kubernetes_version="1.16.10"


# WebApp CORS Origins
allowed_origins=["https://usermanagement.dataservices-pvn.doverfs.com"]
