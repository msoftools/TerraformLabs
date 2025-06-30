terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

resource "virtualbox_vm" "node" {
  count     = 2
  name      = "marioVB-Puppy"
  #name      = format("node-%02d", count.index + 1)
  image     = "/home/mario/Documents/TerraformLabs/VBox/virtualbox.box"
  cpus      = 2
  memory    = "512 mib"
  #user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "hostonly"
    host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

output "IPAddr" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}

output "IPAddr_2" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 2)
}


#Tutorial: https://www.roksblog.de/terraform-virtualbox-provider-terrafarm/
#https://jroliva.net/2024/02/12/how-to-terraform-and-virtualbox/



