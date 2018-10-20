provider "aws" {
  region = "eu-west-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


data "template_file" "init" {
  template = "${file("init.tpl")}"

  vars {
    master_dns = "${aws_instance.rabbitmq_master.private_dns}"
  }
}


resource "aws_instance" "rabbitmq_master" {
  ami                       = "${data.aws_ami.ubuntu.id}"
  instance_type             = "t2.micro"
  count                     = 1
  // your public ssh key
  //key_name                  = ""
  
  user_data                 = "${file("user_data_master.web")}"

  tags {
    Name = "RabbitMQ-Master"
  }
}

resource "aws_instance" "rabbitmq_slave" {
  ami                       = "${data.aws_ami.ubuntu.id}"
  instance_type             = "t2.micro"
  count                     = 1
  // your public ssh key
  //key_name                  = ""

  user_data                 = "${data.template_file.init.rendered}"

  tags {
    Name = "RabbitMQ-Slave"
  }
}
