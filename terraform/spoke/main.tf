resource "aws_cloudformation_stack" "Transit-Spoke-Stack" {
  name         = "Transit-Spoke-Stack"
  on_failure   = "ROLLBACK"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    BucketName   = "${var.TransitVpcBucketName}"
    BucketPrefix = "${var.TransitVpcBucketPrefix}"
  }

  template_body = "${file("${path.module}/files/transit_vpc_poller_template.json")}"
}
