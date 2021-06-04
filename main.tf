###---main.tf----конфигурация terraform и провайдеров
terraform {
  backend "s3" {            #--создание места хранения backends .tfstate 
    bucket = "astra-simple-web-shop"
#    region = "us-east-1"   
    key = "s3-backup/tfstate"
  }
}
provider "aws" {
    profile = "default"
#    region = "us-east-1"
}
