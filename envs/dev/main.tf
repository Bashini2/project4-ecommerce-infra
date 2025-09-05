provider "aws" {
  region = "ap-south-1"
}

module "network" {
  source              = "../../modules/network"
  project             = "project4"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az_public           = "ap-south-1a"
  az_private          = "ap-south-1b"
}
