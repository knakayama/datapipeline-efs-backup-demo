resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}"
  public_key = "${file("${path.module}/keys/key_pair.pub")}"
}

resource "aws_instance" "ec2" {
  ami                         = "${data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.ec2_config["instance_type"]}"
  vpc_security_group_ids      = ["${aws_security_group.ec2.id}"]
  subnet_id                   = "${aws_subnet.public.id}"
  key_name                    = "${aws_key_pair.key_pair.key_name}"
  user_data                   = "${file("${path.module}/user_data/cloud_config.yml")}"
  iam_instance_profile        = "${aws_iam_instance_profile.instance_profile.id}"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
  }

  tags {
    Name = "${var.name}-ec2"
  }
}
