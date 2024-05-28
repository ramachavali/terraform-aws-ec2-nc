resource "aws_instance" "education_bastion" {
  ami                         = data.aws_ami.ubuntu20.id
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = aws_key_pair.deployer.key_name
  associate_public_ip_address = false
  instance_type               = var.instance_type
  tags = {
    Name = "${random_pet.random.id}-instance"
  }
}
