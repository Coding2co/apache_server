
resource "aws_security_group" "acn_sg" {
  name   = "mysecuritygroup"
  vpc_id = "vpc-03a5ec0ed26b297db"  # Change with your VPC ID

  # SSH access from a specific IP (recommended)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP address for security
  }

  # HTTP access from anywhere (optional)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the public for HTTP
  }

  # Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "ec2_instance" {
  ami               = "ami-0df8c184d5f6ae949"  # Change to your desired AMI ID (Amazon Linux for us-east-1)
  instance_type     = "t2.micro"
  vpc_security_group_ids = [aws_security_group.acn_sg.id]
  key_name          = "demoserver"  # Change to your key-pair name
  tags = {
    "OS" = "amazon"
  }

  root_block_device {
    encrypted = true
  }
}

# Output the public IP of the EC2 instance
output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2_instance.public_ip
}

