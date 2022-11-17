module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name = var.vpc_name
  cidr = var.vpc_CIDR
  azs = [var.zone1,var.zone2,var.zone3]
  private_subnets = [var.cidr_priv_sub_1,var.cidr_priv_sub_2,var.cidr_priv_sub_3]
  public_subnets = [var.cidr_pub_sub_1,var.cidr_pub_sub_2,var.cidr_pub_sub_3]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Terraform = "true"
    Environment = "Prod"
    Project = var.projectName
  }
  vpc_tags = {
    Name = var.vpc_name
    Project = var.projectName
  }
}

