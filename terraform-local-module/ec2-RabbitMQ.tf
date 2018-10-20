provider "aws" {
  region = "eu-west-1"
}

data "template_file" "init" {
  template = "${file("init.tpl")}"

  vars {
    master_dns = "${module.ec2_rabbitmq_master.private_dns}"
  }
}

module "ec2_rabbitmq_master" {
  source                    = "modules/ec2-instance"
  ami                       = "ami-0773391ae604c49a4" 
  vpc                       = "default"
  is_public                 = "true"
  create_eip                = true
  instance_type             = "t2.micro"
  // your public ssh key
  //key_name                = ""
  volume_size               = "8"
  disable_api_termination   = false
  instance_name             = "rabbitmq-master"
  user_data                 = "${file("user_data_master.web")}"

}

module "ec2_rabbitmq_slave" {
  source                    = "modules/ec2-instance"
  ami                       = "ami-0773391ae604c49a4"
  vpc                       = "default"
  is_public                 = "true"
  create_eip                = true
  instance_type             = "t2.micro"
  // your public ssh key
  //key_name                = ""
  volume_size               = "8"
  disable_api_termination   = false
  instance_name             = "rabbitmq-slave"
  user_data                 = "${data.template_file.init.rendered}"
}
