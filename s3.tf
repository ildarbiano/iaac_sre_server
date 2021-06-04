###---s3.tf
#---создание ресурса с приданием ему имени и списка контроля доступа - acl
resource "aws_s3_bucket" "static" {
  bucket = "s3-website-html"
  acl    = "public-read"
#  policy = aws_s3_bucket_policy.public_read   #---Действительный документ JSON политики сегмента
  website {
    index_document = "index.html"
    error_document = "error.html"
/*    routing_rules = <<EOF
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
  bucket = aws_s3_bucket.static.id

  block_public_acls   = true
  block_public_policy = true
}  
