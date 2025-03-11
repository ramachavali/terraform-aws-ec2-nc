resource "sshkey_rsa_key_pair" "default" {
  bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "${random_pet.random.id}-key"
  public_key = sshkey_rsa_key_pair.default.public_key
}
