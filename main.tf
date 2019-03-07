provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}
resource "aws_instance" "pubinstance" {
  ami = "ami-5b673c34"
  instance_type = "t2.micro"
#  vpc_id = "${aws_vpc.main.id}"
  key_name = "Bharat123"
 # user = "ec2-user"
  tags = {
    Name = "MypublicInstance"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > inventory"
   }

  provisioner "local-exec" {
    command = "sleep 120; ansible-playbook -i inventory -u ec2-user --private-key Bharat123.pem provision.yml"
  }

}
