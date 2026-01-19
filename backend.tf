terraform {
  backend "s3" {
    bucket  = "vishnu-terraform-state-11808"
    key     = "terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
