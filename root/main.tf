
provider "aws" {
  region = var.region
}

module "vpc" {
  source   = "../modules/vpc"
  vpc_cidr = var.vpc_cidr
  name     = "demo-vpc"
}

module "public_subnet" {
  source = "../modules/public-subnet"
  vpc_id = module.vpc.vpc_id
  cidr   = var.public_cidr
  name   = "public-subnet"
}

module "private_subnet" {
  source = "../modules/private-subnet"
  vpc_id = module.vpc.vpc_id
  cidr   = var.private_cidr
  name   = "private-subnet"
}

module "igw" {
  source = "../modules/igw"
  vpc_id = module.vpc.vpc_id
  name   = "igw"
}

module "nat" {
  source           = "../modules/nat"
  public_subnet_id = module.public_subnet.subnet_id
  name             = "nat"
}

module "public_rt" {
  source    = "../modules/public-rt"
  vpc_id    = module.vpc.vpc_id
  igw_id    = module.igw.igw_id
  subnet_id = module.public_subnet.subnet_id
  name      = "public-rt"
}

module "private_rt" {
  source    = "../modules/private-rt"
  vpc_id    = module.vpc.vpc_id
  nat_id    = module.nat.nat_id
  subnet_id = module.private_subnet.subnet_id
  name      = "private-rt"
}

module "ec2" {
  source        = "../modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.public_subnet.subnet_id
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}
