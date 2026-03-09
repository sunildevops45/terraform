region         = "ap-south-1"

vpc_cidr       = "10.0.0.0/16"
public_cidr    = "10.0.1.0/24"
private_cidr   = "10.0.2.0/24"

ami            = "ami-0f5ee92e2d63afc18"  # Amazon Linux 2 (Mumbai)
instance_type  = "t2.micro"
key_name       = "my-keypair"