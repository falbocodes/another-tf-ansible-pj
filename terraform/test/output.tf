output "main_public_ip" {
  value = aws_instance.main.public_ip
}


output "worker_public_ip" {
    value = aws_instance.worker.public_ip
}
