terraform{
 backend "azurerm"{
  storage_account_name = "saasopstfstate"
    container_name = "saastfstate"
    key = "premlondhe"
    access_key = ""
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=2.47.0"
    }
  }

  required_version = ">= 0.14"

}
