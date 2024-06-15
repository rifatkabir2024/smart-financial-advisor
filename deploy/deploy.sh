bash
# Copy code
# !/bin/bash

# Variables
resourceGroup="SmartFinAdvisorRG"
location="eastus"
iotHubName="SmartFinAdvisorIoTHub"
sqlServerName="smartfinadvisor-sql-server"
sqlDbName="SmartFinAdvisorDB"
synapseWorkspace="SmartFinAdvisorSynapse"
aiPersonalizer="SmartFinAdvisorPersonalizer"
aiMetrics="SmartFinAdvisorMetrics"

# Create Resource Group
az group create --name $resourceGroup --location $location

# Create IoT Hub
az iot hub create --name $iotHubName --resource-group $resourceGroup --location $location

# Create SQL Server and Database
az sql server create --name $sqlServerName --resource-group $resourceGroup --location $location --admin-user myadmin --admin-password P@ssw0rd1234
az sql db create --resource-group $resourceGroup --server $sqlServerName --name $sqlDbName --service-objective S0

# Create Synapse Analytics Workspace
az synapse workspace create --name $synapseWorkspace --resource-group $resourceGroup --location $location --storage-account $synapseStorage --file-system $synapseFileSystem

# Create Azure AI Personalizer
az cognitiveservices account create --name $aiPersonalizer --resource-group $resourceGroup --kind Personalizer --sku S0 --location $location

# Create Azure AI Metrics Advisor
az cognitiveservices account create --name $aiMetrics --resource-group $resourceGroup --kind MetricsAdvisor --sku S0 --location $location

echo "Deployment complete!"
