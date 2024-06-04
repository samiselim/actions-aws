terraform {
  backend "s3" {
    bucket = "oidc-terraform-tfstate-file"
    key = "oidc-infra.tfstate"
    region = "eu-west-3"
  }
}

module "vpc" {
  source                 = "./modules/VPC"
  vpc_cidr               = var.vpc_cidr
  public_subnets_config  = var.public_subnets_config
  private_subnets_config = var.private_subnets_config
  vpc_name               = var.vpc_name
} 

module "sg" {
  source = "./modules/SG"
  sg_config = var.sg_config
  sg_name = "sg"
  vpc_id = module.vpc.vpc_id
}

module "instance" {
  source = "./modules/EC2"
  ec2_config = var.jenkins_cfg
  ec2_subnet_id = module.vpc.public_subnet_ids[0]
  vpc_id = module.vpc.vpc_id
  sg = module.sg.sg_id
  ami = data.aws_ami.aws_image_latest.id
}
