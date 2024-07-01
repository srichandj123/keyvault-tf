module "rg-keyvault" {
  source  = "app.terraform.io/jakka/rg/module"
  version = "3.1.1"
  loc     = "Central US"
  rg_name = "keyvault-rg"
  tags = {
    Client = "OCC"
  }
}

data "azurerm_client_config" "current" {}
resource "azurerm_key_vault" "kv" {
  name                = "jakk-key-vault"
  location            = module.rg-keyvault.location
  resource_group_name = module.rg-keyvault.rg_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.client_id
    key_permissions = [
      "Get", "List", "Delete", "Create"
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }

}