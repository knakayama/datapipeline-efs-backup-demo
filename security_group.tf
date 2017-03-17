resource "aws_security_group" "ec2" {
  name_prefix = "${var.name}-ec2-sg-"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${var.name}-ec2-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.my_ip.result["ip"]}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_security_group" "datapipeline" {
  name_prefix = "${var.name}-datapipeline-sg-"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${var.name}-datapipeline-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.external.my_ip.result["ip"]}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-datapipeline-sg"
  }
}

resource "aws_security_group" "efs" {
  name_prefix = "${var.name}-efs-sg-"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${var.name}-efs-sg"

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.ec2.id}",
      "${aws_security_group.datapipeline.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.name}-efs-sg"
  }
}
