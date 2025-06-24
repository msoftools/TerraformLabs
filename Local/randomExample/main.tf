provider "random" {
  
}

resource "random_pet" "name" {
  length=3
}


resource "local_file" "name" {
   file_permission = "0400"
   filename = "learning.txt"
   content = "Welcome to the terraform platform "
}


output "random_pet_name" {
  value = random_pet.name.id
}

output "random_file_id" {
  value = local_file.name.id
}

output "random_file_name" {
  value = local_file.name.name
}