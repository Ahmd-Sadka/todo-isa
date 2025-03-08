module "vpcModule" {
  source = "./modules/vpcModule"
  project_name = "todo"
  vpc_cidr = "10.0.0.0/16"


}

module "ecrModule" {
  source = "./modules/ecrModule"
  frontendRepository_name = "frontend"
  backendRepository_name = "backend"
}

module "eksModule" {
  source = "./modules/eksModule"
  cluster_name = var.cluster_name
  subnet_ids = module.vpcModule.public_subnet_ids
}

module "pipelineModule" {
  source = "./modules/pipelineModule"
  public_key_path = var.public_key_path
  security_group_id = module.vpcModule.security_group_id
  subnet_id = module.vpcModule.public_subnet_ids[0]
  
}

module "backupModule" {
  source = "./modules/backupModule"
  target_backup_arn = module.pipelineModule.Jenkins_instance_arn
  
}

module "s3Module" {
  source = "./modules/s3Module"

  bucket_name        = "todos-elb-logs-${random_id.suffix.hex}"
  enable_elb_logging = true
  force_destroy      = true
  tags = {
    Environment = "prod"
    LogsType    = "elb"
  }
}