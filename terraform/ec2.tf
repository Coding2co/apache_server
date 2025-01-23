// variable "aws_access_key" {}
// variable "aws_secret_key" {}

resource "aws_security_group" "acn_sg" {
  name   = "mysecuritygroup"
  vpc_id = "vpc-0780fe3cca77ae47b"      //change with your vpc-id

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]         //by-default it open for anywhere, RECOMMENDED to restrict to your IP
  }

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  
}


#EC2-Instance

resource "aws_instance" "ec2_instance"{
 ami = "ami-0df8c184d5f6ae949"        //change to your desired ami-id as it is amazon-linux support in "us-east-1" region.
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.acn_sg.id]
 key_name               = "demoserver"  // change to your key-value pair name.
 tags   = {
   "OS" = "amazon"
 }
 root_block_device {
    encrypted   = true
  }
}



output "public_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}
