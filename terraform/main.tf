module "web" {
  source = "./modules/web-server"

  name          = "web_dev"
  vpc_cidr      = "10.0.0.0/16"
  subnet_cidr   = "10.0.1.0/24"
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  user_data = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      systemctl start nginx
      systemctl enable nginx
      cat > /var/www/html/index.html <<'HTML'
      <!DOCTYPE html>
      <html>
         <head><title>My Infrastructure</title></head>
         <body>
            <h1>Infrastructure created via Terraform module</h1>
         </body>
      </html>
      HTML
   EOF

  tags = {
    Environment = "dev"
    ManageBy    = "Terraform"
  }
}