###---конфигурация terraform и провайдеров---###
#--создание места хранения backends .tfstate 
terraform {
  backend "s3" {            
    bucket = "astra-simple-web-shop"
    region = var.aws-region
    key = "s3.tfstate"
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws-region
}
