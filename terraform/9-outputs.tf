output "k8s-master" {
  value       = aws_instance.k8s-master.public_ip
}
output "k8s-worker1" {
  value       = aws_instance.k8s-worker1.public_ip
}
output "k8s-worker2" {
  value       = aws_instance.k8s-worker2.public_ip
}
output "k8s-worker3" {
  value       = aws_instance.k8s-worker3.public_ip
}
