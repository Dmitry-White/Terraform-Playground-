resource "azurerm_resource_group" "rg" {
  name     = local.resources.name
  location = local.resources.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = "Terraform-Vnet"
  address_space       = [local.network.full_cidr]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "Terraform-Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [local.network.subnet_cidr]
}

resource "azurerm_network_interface" "nic" {
  count = var.instance_count

  name                = "NIC-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "NicConfig-${count.index}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
