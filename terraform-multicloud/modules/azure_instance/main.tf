resource "azurerm_linux_virtual_machine" "instance" {
  count = var.instance_count

  name = "instance-${count.index}"
  size = var.instance_type

  computer_name                   = "vm-${count.index}"
  admin_username                  = local.creds.username
  admin_password                  = local.creds.password
  disable_password_authentication = false

  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  admin_ssh_key {
    username   = local.creds.username
    public_key = file(local.creds.ssh_key_path)
  }

  os_disk {
    caching              = local.storage.caching
    storage_account_type = local.storage.account_type
  }

  source_image_reference {
    publisher = local.image.publisher
    offer     = local.image.offer
    sku       = local.image.sku
    version   = local.image.version
  }
}
