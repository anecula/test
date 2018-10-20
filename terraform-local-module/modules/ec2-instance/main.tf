// Get region from provider
data "aws_region" "current" {
  current = true
}

// Create EC2 instance
resource "aws_instance" "instance" {
  ami                     = "${var.ami}"
  instance_type           = "${var.instance_type}"
  vpc_security_group_ids  = ["${var.vpc_security_group_ids}"]
  key_name                = "${var.key_name}"
  user_data               = "${var.user_data}"
  iam_instance_profile    = "${var.iam_instance_profile}"
  disable_api_termination = "${var.disable_api_termination}"
  

  tags {
    Name        = "${var.instance_name}"
    Environment = "${var.vpc}"
  }

  ebs_block_device {
      device_name           = "/dev/sda1"
      volume_type           = "gp2"
      volume_size           = "${var.volume_size}"
      delete_on_termination = "true"
      encrypted             = "false"
  }

  lifecycle {
        ignore_changes = [ "ebs_block_device", "user_data" ]
  }

}

// Create Extra EBS volume
resource "aws_ebs_volume" "extra" {
  count             = "${var.create_extra_volume}"
  size              = "${var.extra_volume_size}"
  type              = "${var.extra_volume_type}"

  tags {
    Name = "${var.extra_volume_name}"
  }

}

resource "aws_volume_attachment" "attach_extra" {
  count        = "${var.create_extra_volume}"
  device_name  = "/dev/sdf"
  volume_id    = "${aws_ebs_volume.extra.id}"
  instance_id  = "${aws_instance.instance.id}"
  skip_destroy = "${var.extra_volume_skip_destroy}"

  lifecycle {
        ignore_changes = [ "instance_id", "id" ]
  }

}

// Create and associate Elastic IP
resource "aws_eip" "instance_eip" {
  count    = "${var.create_eip}"
  instance = "${aws_instance.instance.id}"
  vpc      = true
}
