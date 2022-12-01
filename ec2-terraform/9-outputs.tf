output "control-pvt" {
  value       = aws_instance.control.private_ip
}
output "k8s-master-pvt" {
  value       = aws_instance.k8s-master.private_ip
}
output "k8s-worker0-pvt" {
  value       = aws_instance.k8s-worker[0].private_ip
}
output "k8s-worker1-pvt" {
  value       = aws_instance.k8s-worker[1].private_ip
}
output "k8s-worker2-pvt" {
  value       = aws_instance.k8s-worker[2].private_ip
}
output "control-pub" {
  value       = aws_instance.control.public_ip
}
output "k8s-master-pub" {
  value       = aws_instance.k8s-master.public_ip
}
output "k8s-worker0-pub" {
  value       = aws_instance.k8s-worker[0].public_ip
}
output "k8s-worker1-pub" {
  value       = aws_instance.k8s-worker[1].public_ip
}
output "k8s-worker2-pub" {
  value       = aws_instance.k8s-worker[2].public_ip
}
