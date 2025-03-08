terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }



#   backend "s3" {
#     bucket         = var.bucket_name
#     key            = "global/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#    #dynamodb_table = module.terraform_backend.dynamodb_table_name
#   }
# }
}

provider "aws" {
    region = "us-east-1"
}