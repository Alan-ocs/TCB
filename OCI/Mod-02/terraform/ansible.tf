provisioner "remote-exec" {
 inline = [
 "ansible-playbook instance.yml"
]
}