terraform {
  backend "s3" {
    bucket = "shuja-bucket1"
    key    = "tools/state"
    region = "us-east-1"
  }
}