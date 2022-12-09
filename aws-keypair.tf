# creating ssh-key.
# resource "tls_private_key" "key" {
#   algorithm = "RSA"
# }

# resource "local_file" "private_key" {
#   filename          = "key-tf.pem"
#   sensitive_content = tls_private_key.key.private_key_pem
#   file_permission   = "0400"
# }

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")
} 