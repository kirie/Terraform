variable "cidrs" { default = [] }

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "kirie" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.kirie.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}

module "consul" {
  source = ""
  aws_region  = "us-east-1"
  num_servers = "3"
}
