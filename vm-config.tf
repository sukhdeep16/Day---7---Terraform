resource "azurerm_virtual_machine" "example" {
  name                  = "VM-By-Code"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  vm_size               = "Standard_F2s" # VM size similar to t2.micro in AWS

  storage_os_disk {
    name              = "myOsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "hostname-sukhdeep"
    admin_username = "abcd" # No password required when using SSH keys
  }

  os_profile_linux_config {
    disable_password_authentication = true # Disable password authentication
    ssh_keys {
      path     = "/home/abcd/.ssh/authorized_keys"      # Path where the key will be added
      key_data = file("SSH-Keys/azure-ssh-keypair.pub") # Load public key from the specified file
    }
  }


}

output "public_ip" {
  value = azurerm_public_ip.example.ip_address
}

output "ssh-key_data" {
  value = file("SSH-Keys/azure-ssh-keypair.pub")
}

