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

module "security" {
  source = "../../modules/security"
  vpc_id = module.network.vpc_id
}
module "compute" {
  source            = "../../modules/compute"
  project           = "project4"
  public_subnet_id  = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
  frontend_sg_id    = module.security.frontend_sg_id
  backend_sg_id     = module.security.backend_sg_id
  key_name          = "project4-key"
}

