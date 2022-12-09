resource "aws_instance" "web1" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "Node1"
  }
  user_data = file("${path.module}/nodeinitialize.sh")
}


resource "aws_instance" "web2" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key-tf.key_name
  vpc_security_group_ids = ["${aws_security_group.allow_tls.id}"]
  tags = {
    Name = "master"
  }
  user_data = file("${path.module}/ansiblemaster.sh")
}