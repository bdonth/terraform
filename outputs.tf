

output "public_ip" {
  value = "${aws_instance.demoinstance.public_ip}"
}



