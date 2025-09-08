terraform {
  backend "s3" {
    bucket  = "ecommerces3bucketbashini"
    key     = "envs/dev/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
