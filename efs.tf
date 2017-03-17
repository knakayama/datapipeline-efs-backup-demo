resource "aws_efs_file_system" "efs" {
  count            = 2
  creation_token   = "${var.name}-${count.index}"
  performance_mode = "generalPurpose"

  tags {
    Name = "${var.name}-efs-${count.index}"
  }
}

resource "aws_efs_mount_target" "efs" {
  count           = 2
  file_system_id  = "${element(aws_efs_file_system.efs.*.id, count.index)}"
  subnet_id       = "${aws_subnet.public.id}"
  security_groups = ["${aws_security_group.efs.id}"]
}
