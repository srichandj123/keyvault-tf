#Storageaccount
resource "azurerm_storage_account" "stgkv" {
  name                          = ""
  resource_group_name           = azurerm_key_vault.kv.resource_group_name
  location                      = azurerm_key_vault.kv.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = false
  network_rules {
    default_action             = "allow"
    virtual_network_subnet_ids = [azurerm_subnet.snet1.id]
  }
  tags = local.tags
}

#vnet
resource "azurerm_virtual_network" "vnet1" {
  name                = "VNET-1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_key_vault.kv.location
  resource_group_name = azurerm_key_vault.kv.resource_group_name
}

#Subnet
resource "azurerm_subnet" "snet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_key_vault.kv.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}