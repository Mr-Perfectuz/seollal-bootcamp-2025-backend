terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "Korea South"
}

resource "azurerm_service_plan" "example" {
  name                = "example-app-service-plan"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "B1"
}
resource "azurerm_linux_web_app" "example" {
  name                = "anvar-ziyodov" # Must be globally unique
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  site_config {
    container_registry_use_managed_identity = false

    application_stack {
      docker_image_name   = "bootcamp:latest"
      docker_registry_url = "https://${azurerm_container_registry.registry.login_server}"
      docker_registry_username = azurerm_container_registry.registry.admin_username
      docker_registry_password = azurerm_container_registry.registry.admin_password
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }

  lifecycle {
    ignore_changes = [ site_config[0].application_stack[0].docker_image_name ]
  }
}

  resource "azurerm_container_registry" "registry" {
    name = "bootcamp"
    resource_group_name = azurerm_resource_group.example.name
    location =  azurerm_resource_group.example.location
    sku = "Basic"
    admin_enabled = true
  }
