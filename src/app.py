import os
from azure.iot.hub import IoTHubRegistryManager
from azure.ai.personalizer import PersonalizerClient
from azure.identity import DefaultAzureCredential
from azure.synapse import SynapseManagementClient

# Azure credentials and configuration
subscription_id = os.getenv("AZURE_SUBSCRIPTION_ID")
resource_group = "SmartFinAdvisorRG"
iot_hub_name = "SmartFinAdvisorIoTHub"
personalizer_endpoint = os.getenv("PERSONALIZER_ENDPOINT")
personalizer_api_key = os.getenv("PERSONALIZER_API_KEY")

# IoT Hub Registry Manager
iot_registry_manager = IoTHubRegistryManager.from_connection_string(os.getenv("IOT_HUB_CONNECTION_STRING"))

# Personalizer Client
personalizer_client = PersonalizerClient(endpoint=personalizer_endpoint, credential=DefaultAzureCredential())

# Synapse Management Client
synapse_client = SynapseManagementClient(credential=DefaultAzureCredential(), subscription_id=subscription_id)

def analyze_financial_data(user_data):
  
    print("Analyzing financial data...")
    # Add data analysis logic here
    total_expenses = user_data["expenses"]
    total_income = user_data["income"]
    savings = user_data["savings"]

    # Calculate the percentage of expenses to income
    expense_percentage = (total_expenses / total_income) * 100

    # Determine the financial health based on the expense percentage
    if expense_percentage <= 50:
        financial_health = "Good"
    elif expense_percentage <= 75:
        financial_health = "Average"
    else:
        financial_health = "Poor"

    # Update the user_data dictionary with the financial health
    user_data["financial_health"] = financial_health

    # Return the updated user_data
    return user_data

def get_personalized_advice(user_data):
    # Get personalized advice from the Personalizer service
    response = personalizer_client.rank(user_data)
    advice = response.reward_action_id
    return advice

def track_spending(device_id):
    # Implement your IoT Hub logic here
    # Example implementation:
    print(f"Tracking spending for device: {device_id}")
    # Add your IoT Hub logic here
    # Example implementation:
    telemetry_data = {
        "device_id": device_id,
        "temperature": 25.5,
        "humidity": 60.2,
        "pressure": 1013.25
    }
    
    # Send telemetry data to IoT Hub
    iot_registry_manager.send_device_to_cloud_message(device_id, str(telemetry_data))
    
    # Print confirmation message
    print("Telemetry data sent to IoT Hub:", telemetry_data)

def main():
    user_data = {
        "income": 50000,
        "expenses": 20000,
        "savings": 10000
    }
    analyze_financial_data(user_data)
    advice = get_personalized_advice(user_data)
    print("Personalized Financial Advice:", advice)
    track_spending("device123")

if __name__ == "__main__":
    main()
