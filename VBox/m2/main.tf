terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}


provider "virtualbox" {
   delay      = 60
   mintimeout = 10
}


resource "virtualbox_vm" "node" {
  count = 1
  name  = "${ format("node-%02d", count.index + 1)}"
  #image  = "https://app.vagrantup.com/alpine/boxes/alpine64/versions/3.7.0/providers/virtualbox/unknown/vagrant.box"
  image     = "/home/mario/Documents/TerraformLabs/VBox/virtualbox.box"
  cpus      = 2
  memory    = "2048 mib"
  #user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "bridged"
    #device         = "IntelPro1000MTDesktop"
    host_interface = "enp0s3"
    # On Windows use this instead
    # host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

resource "null_resource" "ssh_docker" {
  # Other resource settings  
  connection {
    type        = "ssh"
    user        = "vagrant"
    password = "vagrant"
    #private_key = file("/path/to/your/private/key.pem")
    host        = virtualbox_vm.node[0].network_adapter[0].ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, World'",
      #"sudo apt-get update",
      #"sudo apt-get install ca-certificates curl gnupg"
    ]
  }

}


output "IPAddress" {
  value = element(virtualbox_vm.node.*.network_adapter.0.ipv4_address, 1)
}
