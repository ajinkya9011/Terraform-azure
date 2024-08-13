terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.0"
    }
  }
  backend "azurerm" {         #empty values has to passed in backed for azure devops as the settings provided in the UI
    resource_group_name = ""
    storage_account_name = ""
    container_name = ""
    key                  = ""

  }
}

