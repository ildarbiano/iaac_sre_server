###---s3.tf
#---создание ресурса с приданием ему имени и списка контроля доступа - acl
resource "aws_s3_bucket" "static" {
  bucket = var.bucket_name
  acl    = "public-read"
  policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "PublicReadForGetBucketObjects",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.bucket_name}/templates/*"
    }
  ]
}
  EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

#---политикa сегмента, которая делает его содержимое общедоступным
resource "aws_s3_bucket_public_access_block" "static_web" {
  bucket = aws_s3_bucket.static.id
#  block_public_acls   = true         #--Defaults to =false - Block all public access -Off
#  block_public_policy = true         #--Defaults to =false - Block all public access -Off
#---то есть не прописывая эти блоки, откроется полный доступ а s3 bucket
}
