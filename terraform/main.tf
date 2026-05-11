locals {
  name_prefix = "${var.project}-${var.environment}"
  common_tags = {
    project     = var.project
    environment = var.environment
    managed_by  = "terraform"
  }
}

# VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "vpc-${local.name_prefix}"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = local.common_tags
}

# EKS Cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.0.0"

  cluster_name    = "eks-${local.name_prefix}"
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 5
      desired_size = var.eks_node_count
      instance_types = [var.eks_node_type]
    }
  }

  tags = local.common_tags
}

# ECR - Frontend
resource "aws_ecr_repository" "frontend" {
  name                 = "${local.name_prefix}-frontend"
  image_tag_mutability = "MUTABLE"
  tags                 = local.common_tags
}

# ECR - Backend
resource "aws_ecr_repository" "backend" {
  name                 = "${local.name_prefix}-backend"
  image_tag_mutability = "MUTABLE"
  tags                 = local.common_tags
}
