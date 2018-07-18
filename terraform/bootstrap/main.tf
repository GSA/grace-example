resource "aws_s3_bucket" "backend" {
  provider      = "aws.mgmt"
  bucket_prefix = "${var.bucket_prefix}"

  versioning {
    enabled = true
  }
}
