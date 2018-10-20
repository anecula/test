output "instance_id" {
  value = "${aws_instance.instance.id}"
}
output "private_dns" {
  value = "${aws_instance.instance.private_dns}"
}

output "elastic_ip" {
  value = "${aws_eip.instance_eip.public_ip}"
}
