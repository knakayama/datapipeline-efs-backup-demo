resource "aws_cloudformation_stack" "sns" {
  name          = "${var.name}-sns-stack"
  template_body = "${file("${path.module}/templates/sns.yml")}"

  parameters {
    Email = "${var.datapipeline_config["email"]}"
  }
}

resource "aws_cloudformation_stack" "datapipeline" {
  name          = "${var.name}-datapipeline-stack"
  template_body = "${file("${path.module}/templates/datapipeline.yml")}"

  parameters {
    myInstanceType             = "${var.datapipeline_config["instance_type"]}"
    mySubnetId                 = "${aws_subnet.public.id}"
    mySecurityGroupId          = "${aws_security_group.datapipeline.id}"
    myEFSId                    = "${aws_efs_file_system.efs.0.id}"
    myEFSSource                = "${element(aws_efs_mount_target.efs.*.dns_name, 0)}"
    myEFSBackup                = "${element(aws_efs_mount_target.efs.*.dns_name, 1)}"
    myTimeZone                 = "${var.datapipeline_config["timezone"]}"
    myImageId                  = "${data.aws_ami.amazon_linux.id}"
    myTopicArn                 = "${aws_cloudformation_stack.sns.outputs["TopicArn"]}"
    myS3LogBucket              = "${aws_s3_bucket.s3.id}"
    myDataPipelineResourceRole = "${aws_iam_instance_profile.datapipeline_resource.name}"
    myDataPipelineRole         = "${aws_iam_role.datapipeline_role.name}"
    myKeyPair                  = "${aws_key_pair.key_pair.key_name}"
    myPeriod                   = "${var.datapipeline_config["period"]}"
    Tag                        = "${var.name}"
  }
}
