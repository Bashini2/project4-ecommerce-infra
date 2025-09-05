output "frontend_sg_id" {
  value = aws_security_group.frontend_sg.id
}

output "backend_sg_id" {
  value = aws_security_group.backend_sg.id
}

output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}
