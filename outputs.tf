# output "aws_instance_id" {
#   value = aws_instance.nginx1.id
# }

# output "aws_instance_public_ip" {
#   value = "ssh -i ${var.keypair}.pem ${local.OS_user}@${aws_instance.nginx1.public_ip}"
# }

# output "aws_instance_public_ip_url" {
#   value = "http://${aws_instance.nginx1.public_ip}:8080"
# }

output "aws_instance_public_ip_docker" {
  value = "ssh -i ${var.keypair}.pem ${local.OS_user}@${aws_instance.docker_instance.public_ip}"
}

output "aws_instance_public_ip_url_docker" {
  value = "http://${aws_instance.docker_instance.public_ip}:8000"
}