provider "aws" {

	region = "us-east-1"

}

data "aws_ami" "latest-xenial" {

	most_recent = true
	owners = ["099720109477"] # Canonical

	filter {
		name   = "name"
		values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
	}

	filter {
		name = "virtualization-type"
		values = ["hvm"]
	}

}
resource "aws_security_group" "allow_in_out" {

	name = "allow_in_out"
	ingress {

		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = [ "0.0.0.0/0" ]

	}

	ingress {

		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = "${var.mgmt_cidr_blocks}"

	}

	egress {

		from_port = 0
		to_port = 0
		protocol = -1
		cidr_blocks = [ "0.0.0.0/0" ]

	}

}

resource "aws_instance" "mydeploy" {

	ami = "${data.aws_ami.latest-xenial.id}"
	instance_type = "t2.micro"
	user_data = file("myapp.sh")
	key_name = "mydeploy"
	security_groups = [ "allow_in_out" ]

}
