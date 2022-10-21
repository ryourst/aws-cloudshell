
resource "aws_instance" "k8s-master" {
  instance_type          = "t3.medium"
  ami                    = data.aws_ami.ubuntu_node.id
  key_name               = aws_key_pair.lab_key.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  subnet_id              = aws_subnet.lab_net.id

  root_block_device {
    volume_size = 35
  }

  tags = {
    name = "lab"
  }
}

resource "aws_instance" "k8s-worker1" {
  instance_type          = "t3.medium"
  ami                    = data.aws_ami.ubuntu_node.id
  key_name               = aws_key_pair.lab_key.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  subnet_id              = aws_subnet.lab_net.id

  root_block_device {
    volume_size = 35
  }
  ebs_block_device {
    device_name           = "/dev/sdd"
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    name = "lab"
  }
}


resource "aws_instance" "k8s-worker2" {
  instance_type          = "t3.medium"
  ami                    = data.aws_ami.ubuntu_node.id
  key_name               = aws_key_pair.lab_key.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  subnet_id              = aws_subnet.lab_net.id

  root_block_device {
    volume_size = 35
  }
  ebs_block_device {
    device_name           = "/dev/sdd"
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    name = "lab"
  }
}
resource "aws_instance" "k8s-worker3" {
  instance_type          = "t3.medium"
  ami                    = data.aws_ami.ubuntu_node.id
  key_name               = aws_key_pair.lab_key.id
  vpc_security_group_ids = [aws_security_group.lab_sg.id]
  subnet_id              = aws_subnet.lab_net.id

  root_block_device {
    volume_size = 35
  }
  ebs_block_device {
    device_name           = "/dev/sdd"
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  tags = {
    name = "lab"
  }
}

