terraform {
  backend "s3" {            #---#--создание места хранения .tfstate 
    
    bucket = "astra-simple-web-shop"
    region = "us-east-1"
    key = "s3-backup/tfstate"
  }
}

provider "aws" {
  region ="us-east-1"
}
#---создание ресурса с приданием ему имени и списка контроля доступа - acl
resource "aws_s3_bucket" "b25sdr4" {
  bucket = "s3-website-html"
  acl    = "public-read"
/*  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }*/
}
#---политикa сегмента, которая делает его содержимое общедоступным
resource "aws_s3_bucket_public_access_block" "static_web" {
  bucket = aws_s3_bucket.b25sdr4.id

  block_public_acls   = true
  block_public_policy = true
}  
