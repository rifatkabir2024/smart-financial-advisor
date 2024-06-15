# powershell
# Copy code
# Variables
$resourceGroup = "SmartFinAdvisorRG"
$location = "eastus"
$iotHubName = "SmartFinAdvisorIoTHub"
$sqlServerName = "smartfinadvisor-sql-server"
$sqlDbName = "SmartFinAdvisorDB"
$synapseWorkspace = "SmartFinAdvisorSynapse"
$aiPersonalizer = "SmartFinAdvisorPersonalizer"
$aiMetrics = "SmartFinAdvisorMetrics"

# Create Resource Group
New-AzResourceGroup -Name $resourceGroup -Location $location

# Create IoT Hub
New-AzIotHub -ResourceGroupName $resourceGroup -Name $iotHubName -Location $location

# Create SQL Server and Database
New-AzSqlServer -ResourceGroupName $resourceGroup -ServerName $sqlServerName -Location $location -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "myadmin", (ConvertTo-SecureString "P@ssw0rd1234" -AsPlainText -Force))
New-AzSqlDatabase -ResourceGroupName $resourceGroup -ServerName $sqlServerName -DatabaseName $sqlDbName -RequestedServiceObjectiveName "S0"

# Create Synapse Analytics Workspace
New-AzSynapseWorkspace -ResourceGroupName $resourceGroup -Name $synapseWorkspace -Location $location -DefaultDataLakeStorageAccountName $synapseStorage -DefaultDataLakeStorageFileSystem $synapseFileSystem

# Create Azure AI Personalizer
New-AzCognitiveServicesAccount -ResourceGroupName $resourceGroup -Name $aiPersonalizer -Kind "Personalizer" -SkuName "S0" -Location $location

# Create Azure AI Metrics Advisor
New-AzCognitiveServicesAccount -ResourceGroupName $resourceGroup -Name $aiMetrics -Kind "MetricsAdvisor" -SkuName "S0" -Location $location

Write-Host "Deployment complete!"
