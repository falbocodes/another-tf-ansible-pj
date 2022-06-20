resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "key-${var.proj-name}"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./key.pem"
  }
}
resource "aws_instance" "main" {
  ami                    = var.centos-ami-id
  instance_type          = var.instance-type
  key_name               = aws_key_pair.key_pair.id
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id = aws_subnet.swarm_nodes.id
  user_data              = file(var.warmup-path)
  iam_instance_profile = aws_iam_instance_profile.Ec2InstanceProfile.name


  tags = {
    Name = "${var.proj-name}-main"
  }
}

resource "aws_instance" "worker" {
  ami                    = var.centos-ami-id
  instance_type          = var.instance-type
  key_name               = aws_key_pair.key_pair.id
  vpc_security_group_ids = [aws_security_group.default.id]
  subnet_id              = aws_subnet.swarm_nodes.id
  iam_instance_profile   = aws_iam_instance_profile.Ec2InstanceProfile.name
  user_data              = file(var.warmup-path)


  tags = {
    Name = "${var.proj-name}-worker"
  }
}

resource "aws_ebs_volume" "ebs-master" {
  availability_zone = aws_subnet.swarm_nodes.availability_zone
  size              = var.docker-volume
}

resource "aws_volume_attachment" "ebs-master-att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs-master.id
  instance_id = aws_instance.main.id
}

resource "aws_ebs_volume" "ebs-worker" {
  availability_zone = aws_subnet.swarm_nodes.availability_zone
  size              = var.docker-volume
}

resource "aws_volume_attachment" "ebs-worker-att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs-worker.id
  instance_id = aws_instance.worker.id
}

resource "aws_iam_role" "IamRole" {
  name        = "Ec2RoleForSSM-${var.proj-name}"
  description = "EC2 IAM role for SSM access"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : ["ec2.amazonaws.com"]
          },
          "Effect" : "Allow",
        }
      ]
    }
  )
}


resource "aws_iam_instance_profile" "Ec2InstanceProfile" {
  role = aws_iam_role.IamRole.name
  name = "Ec2RoleForSSM-${var.proj-name}"
}
resource "aws_iam_role_policy_attachment" "IamRoleManagedPolicyRoleAttachment0" {
  role       = aws_iam_role.IamRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

