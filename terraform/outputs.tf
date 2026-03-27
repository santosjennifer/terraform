output "web_public_ip" {
  description = "Public IP address of the web instance"
  value       = module.web.public_ip
}

output "web_vpc_id" {
  description = "VPC ID created"
  value       = module.web.vpc_id
}