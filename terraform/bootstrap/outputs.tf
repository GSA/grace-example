output "bucket" {
  value = "${aws_s3_bucket.backend.id}"
}

output "secret" {
  value = "${aws_iam_access_key.mgmt_deployer.secret}"
}

output "access_key" {
  value = "${aws_iam_access_key.mgmt_deployer.id}"
}
