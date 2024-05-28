output "private_key" {
  description = "SSH Private Key"
  value       = nonsensitive(sshkey_rsa_key_pair.default.private_key_pem)
}

output "bastion_public_ip" {
  description = "Public IP of bastion host"
  value       = join("", aws_instance.education_bastion.*.public_ip)
}

output "ssh_connect_string" {
  description = "SSH Connection String"
  value       = "ssh -i key ubuntu@${join("", aws_instance.education_bastion.*.public_ip)}"
}
