output "public_ip" {
  value = "${aws_instance.ec2.public_ip}"
}

output "efs_dns_names" {
  value = "${join(", ", aws_efs_mount_target.efs.*.dns_name)}"
}

output "datapipeline_id" {
  value = "${aws_cloudformation_stack.datapipeline.outputs["DataPipelineId"]}"
}
