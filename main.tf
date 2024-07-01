module "rg-keyvault" {
  source  = "app.terraform.io/jakka/rg/module"
  version = "3.1.1"
  loc     = "Central US"
  rg_name = "keyvault-rg"
  tags    = local.tags
}

data "azurerm_client_config" "current" {}
#Keyvault

resource "azurerm_key_vault" "kv" {
  name                = "jakk-key-vault"
  location            = module.rg-keyvault.location
  resource_group_name = module.rg-keyvault.rg_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.tags
  dynamic "access_policy" {
    for_each = var.settings
    content {
      tenant_id       = data.azurerm_client_config.current.tenant_id
      object_id       = access_policy.value["objid"]
      key_permissions = access_policy.value["kperms"]

      secret_permissions = [
        "Get", "List", "Set"
      ]

      storage_permissions = [
        "Get", "List", "Set"
      ]
    }
  }
}
