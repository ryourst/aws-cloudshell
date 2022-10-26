data "aws_ami" "ubuntu_node" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20220914"]
  }
}

data "aws_ami" "debian11_node" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-11-amd64-20220503-998"]
  }
}

data "aws_ami" "debian10_node" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-10-amd64-20220911-1135"]
  }
}
