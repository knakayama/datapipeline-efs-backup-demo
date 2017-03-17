variable "name" {
  default = "datapipeline-efs-demo"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "ec2_config" {
  default = {
    instance_type = "t2.nano"
  }
}

variable "datapipeline_config" {
  default = {
    instance_type = "t2.nano"
    email         = "_YOUR_EMAIL_"
    timezone      = "Asia/Tokyo"
    period        = "1 hours"
  }
}

data "aws_availability_zones" "az" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "block-device-mapping.volume-type"
    values = ["gp2"]
  }
}
