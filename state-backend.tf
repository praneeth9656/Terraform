terraform {
  backend "s3" {
    bucket = "praneethterraform"
    key    = "praneethterraform/statefile"
    region = "us-east-1"
  }
}
