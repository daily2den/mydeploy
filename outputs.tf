output "public_dns" {

	description = "List of public DNS addresses assigned to the instance"
	value = aws_instance.mydeploy.*.public_dns

}

output "private_dns" {

	description = "List of private DNS addresses"
	value = aws_instance.mydeploy.*.private_dns

}
